# frozen_string_literal: true

RSpec.describe "Articles Query", type: :request, vcr: true do
  let(:headers) do
    { "Content-Type" => "application/json" }
  end

  describe "fetching all the articles" do
    let(:query) do
      %(
        {
          articles {
            title
          }
        }
      )
    end

    it "returns a list of titles", vcr: "list_articles" do
      response = post "/graphql", query: query, headers: headers
      expect(JSON.parse(response.body)["data"]["articles"]).not_to be_empty
    end
  end
end
