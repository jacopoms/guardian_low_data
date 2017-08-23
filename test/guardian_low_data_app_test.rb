require 'test/test_helper'
require 'app/guardian_low_data_app'

class TestGuardianLowDataApp < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    @app ||= GuardianLowDataApp.new # Sinatra::Application
  end

  def test_homepage
    get '/'
    assert_equal last_response.status, 200
  end
end
