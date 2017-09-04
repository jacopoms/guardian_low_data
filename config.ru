require 'rubygems'
require 'bundler'
require 'dotenv/load'

Bundler.require

require_relative 'app/app'

GuardianLowDataApp.run!
