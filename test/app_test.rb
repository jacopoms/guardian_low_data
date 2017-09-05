require_relative 'test_helper'
require_relative '../app/app'

class TestGuardianLowDataApp < Minitest::Test
  include Rack::Test::Methods

  def app
    GuardianLowDataApp # Sinatra::Application
  end

  def test_homepage
    VCR.use_cassette("test_homepage") do
      get '/'
      assert last_response.ok?
      assert_equal last_response.status, 200
      assert last_response.body.include?("class='article-title'")

    end
  end

  def test_secondpage
    VCR.use_cassette("test_secondpage") do
      get '/page/2'
      assert last_response.ok?
      assert_equal last_response.status, 200
      assert last_response.body.include?("class='article-title'")

    end
  end

  def test_lastpage
    VCR.use_cassette("test_lastpage") do
      get '/page/20'
      assert last_response.ok?
      assert_equal last_response.status, 200
      assert last_response.body.include?("class='article-title'")
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

  def test_search
    VCR.use_cassette("test_asearch") do
      post '/search', :q => "Firenze"
      assert last_response.ok?
      assert last_response.body.include?('Firenze')
    end
  end

  # def test_sections
  #   VCR.use_cassette 'test_sections' do
  #     get '/'
  #     assert last_response.ok?
  #     assert last_response.body.include?('section_name')
  #   end
  # end
end
