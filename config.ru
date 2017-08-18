require 'rubygems'
require 'bundler'
require 'dotenv/load'
require 'better_errors'

Bundler.require

require './guardian_low_data_app'

GuardianLowDataApp.run!
