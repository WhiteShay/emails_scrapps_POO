class Scrapper_mail

    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'json'
    
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    page2 = 
    
    city_url = page.xpath('//p/a/@href')
    villes = page.xpath('//p/a')
    
    #on cherche les noms des villes
    tab_cities = [] #tableau avec les noms des villes
    villes.each do |ville|
      tab_cities << ville.text
    end
    
    townhall_url = []
     #ajouter toutes les url dans un tableau
        city_url.each do |url|
            townhall_url << url.text #ajouter toutes les textes des urls dans le tableau
        end
    
    tab_email = [] #créer un tableau qui recupère les mails
    def get_townhall_email(townhall_url,tab_email)
        townhall_url.each do |var|
            page2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/"+var))
            emails = page2.xpath('//*/section[2]/div/table/tbody//tr[4]/td[2]')
            tab_email << emails.text
        end
        tab_email
    end
    
    get_townhall_email(townhall_url,tab_email)
    
    urls = [] #créer un tableau qui récupére les urls
    def get_townhall_urls(townhall_url, urls)
        townhall_url.each do |var|
        url = "http://annuaire-des-mairies.com/" +var
        urls << url
        end
        puts urls
    end
    
    hash_cities = Hash[tab_cities.zip(tab_email)]
    array_citiesmail = Array.new
    
    hash_cities.each do |key, value|
        hash = Hash.new
            hash[key] = value
            array_citiesmail << hash
        end.


    def save_as_json (array_citiesmail)       

        File.open("lib/townhall_emails.json","w"){ |f| f.write array_citiesmail.to_json }
    
    end 
 save_as_json


=begin
        Cette méthode doit save les hashes de array_citiesmail
        dans un fichier townhall_emails.json
=end