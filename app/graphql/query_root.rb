require "graphql"
require_relative "types/article.rb"

class QueryRoot < GraphQL::Schema::Object

  field :article, Types::Article, null: true do
    description "Find an Article by its ID"
    argument :id, String, required: true
  end

  def article(id:)
    GuardianContent::Content.find_by_id(id)
  end
end
