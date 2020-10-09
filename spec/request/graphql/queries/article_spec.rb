# frozen_string_literal: true

RSpec.describe "Article Query", type: :request do
  let(:headers) do
    { "Content-Type" => "application/json" }
  end

  describe "fetching one article by ID" do
    let(:id) { "some-id" }
    let(:title) { "Some Title" }
    let(:article) do
      OpenStruct.new(
        id: id,
        title: title
      )
    end

    let(:query) do
      %(query
        vars(
          $id: String!
        )
        {
          article(id: $id) {
            title
          }
        }
      )
    end

    let(:variables) do
      { id: id.to_s }
    end

    before do
      allow(GuardianContent::Content)
        .to receive(:find_by_id)
        .with(id)
        .and_return(article)
    end

    it "returns the expected result" do
      response = post "/graphql", query: query, variables: variables, headers: headers
      expect(JSON.parse(response.body)["data"]["article"]["title"]).to eql title
    end
  end
end
