class Scrapper

    require 'rubygems'
    require 'nokogiri'
    require 'json'
    require 'csv'
    require 'google_drive'
 
    #1 Première méthode : Collecte de l'email d'une mairie d'une ville du Val d'Oise

    def get_townhall_email(townhall_url)

    #/ on indique un site URL neutre qui sera indiqué dans la prochaine méthode
        page = Nokogiri::HTML(open(townhall_url)) 
        email_array = []

    #/ on divise la string pour pouvoir récupérer uniquement le nom de la ville.
        email = page.xpath('//*[contains(text(), "@")]').text
        town = page.xpath('//*[contains(text(), "Adresse mairie de")]').text.split 

    #/ on indique la position du nom de la ville dans la string pour la récupérer.
        email_array << {town[3] => email}
        puts email_array
        return email_array
    end


    #2 Deuxième méthode : Collecte de toutes les URLs des villes du Val d'Oise
    def get_townhall_urls

        page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
        url_array = []

        urls = page.xpath('//*[@class="lientxt"]/@href') #/ toutes les URLs appartiennent à la classe lientxt

    #/ pour chaque URLs récupérées, il faut leur indiquer l'url parent "http://annuaire-des-mairies.com" : 
        urls.each do |url|

    #/ A l'url parent, on ajoute les urls récupérées du deuxième caractère au dernier caractère, car on veut se débarasser du point devant :
            url = "http://annuaire-des-mairies.com" + url.text[1..-1]
            url_array << url		
        end
    end

    #3 Troisième méthode : Synchronisation des noms des villes et des emails des mairies

    def scrapp_data

        url_array = get_townhall_urls 

    #/ pour chaque URL d'une ville du Val d'Oise, on associe l'adresse mail de la mairie : 
        url_array.each do |townhall_url|
            get_townhall_email(townhall_url)
        end
    end 

    scrapp_data

    def save_as_json (townhall_url)         #Sauvegarde dans un .json, de façon propre, espacée(.pretty_generate)
        File.open("./db/emails.json","w") do |f|
            f.write(JSON.pretty_generate(tempHash))
          end
    end 

    def save_as_csv (townhall_url)          #Sauvegarde dans un .csv, de façon propre et espacée(,"\n")
        File.open("./db/emails.csv","w") do |f|
            f.write(JSON.pretty_generate(tempHash),"\n")
          end
    end

    def save_as_googlesheet (townhall_url)
#Non fait par manque de temps
    end
    

end