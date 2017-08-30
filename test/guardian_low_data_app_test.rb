require 'test/test_helper'
require 'app/guardian_low_data_app'

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
end
