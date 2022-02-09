# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require 'dotenv/load'
Bundler.require
require './config/app'
use GuardianLowDataApp
run lambda {|env| [404, {}, []]}
