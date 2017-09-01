require_relative 'test_helper'
require_relative '../app/guardian_low_data_app'

class TestGuardianLowDataApp < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    GuardianLowDataApp # Sinatra::Application
  end

  def test_homepage
    VCR.use_cassette("test_homepage") do
      get '/'
      assert last_response.ok?
    end
  end

  def test_secondpage
    VCR.use_cassette("test_secondpage") do
      get '/page/2'
      assert_equal last_response.status, 200
    end
  end

  def test_lastpage
    VCR.use_cassette("test_lastpage") do
      get '/page/20'
      assert last_response.ok?
    end
  end

  def test_after_lastpage
    VCR.use_cassette("test_after_lastpage") do
      get '/page/21'
      assert last_response.ok?
      assert last_response.body.include?('No Articles')
    end
  end

  def test_error
    VCR.use_cassette("test_error") do
      begin
        get '/page/-1'
      rescue Exception => e
        assert e.is_a?(StandardError)
        assert e.is_a?(RangeError)
      end
    end
  end
end
