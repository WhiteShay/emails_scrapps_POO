require 'bundler'
require 'dotenv'
require 'rubygem'
require 'nokogiri'
require 'json'
require 'csv'
require 'google_drive'
require 'apps/scrapper'
require 'views/index'
require 'views/done'

bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)

Scrapper_mail.new.perform


