# frozen_string_literal: true

require_relative "../spec_helper.rb"

describe ApplicationController, type: :controller do
  describe '/' do
    it "should allow accessing the home page" do
      VCR.use_cassette('test_homepage') do
        get '/'
        expect(last_response).to be_ok
      end
    end
  end

  describe "/graphql" do
    it "returns a json response" do
      response = post "/graphql", params: {query: {} }
      expect(response).to be_successful
    end
  end
end
