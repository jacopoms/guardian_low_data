# frozen_string_literal: true

# spec/spec_helper.rb
ENV["RACK_ENV"] = "test"
require "dotenv/load"
require "rack/test"
require "rspec"
require "guardian-content"
require "pry"
require_relative "../config/app"

Dir.glob("./spec/support/**/*.rb").sort.each(&method(:require))

module RSpecMixin
  include Rack::Test::Methods
  def app
    GuardianLowDataApp
  end
end

# For RSpec 2.x and 3.x
RSpec.configure do |c|
  c.include RSpecMixin

  # Add the 'vcr' key to a spec context or example to enable vcr. Use a string that uniquely
  # describes the context of network operations, e.g "admin_stripe_payment_details_update_success"
  c.around(:each, vcr: true) do |example|
    vcr_key = example.metadata[:vcr]

    unless vcr_key.is_a?(String)
      raise "You must provide a string with the vcr keyword (you provided #{vcr_key})"
    end

    # Run your tests with RERECORD_VCR=true to re-record vcr fixtures
    options = ENV["RERECORD_VCR"] ? { record: :all } : {}

    VCR.use_cassette(vcr_key, options) { example.run }
  end
end
