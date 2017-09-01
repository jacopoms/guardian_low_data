require 'rubygems'
require 'bundler'
require 'dotenv/load'

Bundler.require

require './app/guardian_low_data_app'

GuardianLowDataApp.run!
