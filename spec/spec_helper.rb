# frozen_string_literal: true

ENV['HANAMI_ENV'] = 'test'
require 'dotenv/load'
require 'hanami/rspec'
require 'guardian-content'
require 'pry'

# Load the application
require_relative '../config/application'

# Configure VCR
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :new_episodes }
end
