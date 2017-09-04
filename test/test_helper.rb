ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'dotenv/load'
require 'httparty'
require 'pry'
require 'guardian-content'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end
