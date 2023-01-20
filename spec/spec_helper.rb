# frozen_string_literal: true

# spec/spec_helper.rb
ENV['RACK_ENV'] = 'test'
require 'dotenv/load'
require 'rspec'
require 'rack/test'
require 'guardian-content'
require 'pry'
require_relative '../config/app'
require 'vcr'

module RSpecMixin
  include Rack::Test::Methods
  def app = GuardianLowDataApp
end
# For RSpec 2.x and 3.x
RSpec.configure { |c| c.include RSpecMixin }

# Setting up VCR
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :new_episodes }
end
