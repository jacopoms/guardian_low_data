require 'rubygems'
require 'bundler'
require 'dotenv/load'
Bundler.require
require './app/app'
GuardianLowDataApp.run!
