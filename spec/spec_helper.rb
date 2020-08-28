# spec/spec_helper.rb
ENV["RACK_ENV"] = "test"
require "dotenv/load"
require "rack/test"
require "rspec"
require "guardian-content"
require "pry"
require_relative "../config/app"
require_relative "../test/vcr_setup"

module RSpecMixin
  include Rack::Test::Methods
  def app
    GuardianLowDataApp
  end
end

# For RSpec 2.x and 3.x
RSpec.configure { |c| c.include RSpecMixin }
