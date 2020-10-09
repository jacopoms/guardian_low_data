# frozen_string_literal: true

require "graphql"
require_relative "../types/article.rb"

module Query
  class Article < GraphQL::Schema::Resolver
    description "Find an Article by its ID"

    type Types::Article, null: true

    argument :id, String, required: true

    def resolve(id:)
      GuardianContent::Content.find_by_id(id)
    end
  end
end
