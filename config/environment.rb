require 'bundler'
require 'nokogiri'
require 'open-uri'
require 'launchy'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil

# require "audio-playback"

require_all 'lib'
