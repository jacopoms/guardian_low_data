# frozen_string_literal: true

require_relative "../spec_helper.rb"

describe ApplicationController, type: :controller, vcr: true do
  let(:headers) do
    { "Content-Type" => "application/json" }
  end
  describe "/" do
    it "should allow accessing the home page" do
      VCR.use_cassette("test_homepage") do
        get "/"
        expect(last_response).to be_ok
      end
    end
  end

  describe "/graphql" do
    let(:id) { "some-id" }
    let(:title) { "Some Title" }
    let(:article) do
      OpenStruct.new(
        id: id,
        title: title
      )
    end

    let(:query) do
      <<~GRAPHQL
        {
          article(id: $id') {
            title
          }
        }
      GRAPHQL
    end

    let(:variables) do
      { id: id.to_s }
    end

    it "returns a json response" do
      response = post "/graphql", query: {}
      expect(response).to be_successful
    end

    before do
      allow(GuardianContent::Content)
        .to receive(:find_by_id)
        .with(id)
        .and_return(article)
    end

    it "returns the expected result" do
      response = post "/graphql", params: { query: query }, variables: variables, headers: headers
      expect(JSON.parse(response.body)["data"]["article"]["title"]).to eql title
    end
  end
end
