# frozen_string_literal: true

describe ApplicationController, type: :controller, vcr: true do
  let(:headers) do
    { "Content-Type" => "application/json" }
  end

  describe "GET /" do
    it "is successful", vcr: "test_homepage" do
      get "/"
      expect(last_response).to be_ok
    end
  end

  describe "POST /graphql" do
    it "is successful", vcr: "test_graphql" do
      response = post "/graphql", query: {}
      expect(response).to be_successful
    end
  end
end
