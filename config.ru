# frozen_string_literal: true

require "rubygems"
require "bundler"
require "dotenv/load"
Bundler.require
require "./config/app"
GuardianLowDataApp.run!
