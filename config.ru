require "rubygems"
require "bundler"
require "dotenv/load"
Bundler.require
require "./config/app"
GuardianLowDataApp.run!
