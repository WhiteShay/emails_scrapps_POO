require 'bundler'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'google_drive'
require 'app/fichier_1'
require 'views/fichier_2'

bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)

Scrapper_mail.new


