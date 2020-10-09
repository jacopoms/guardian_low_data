# frozen_string_literal: true

require "graphql"
require_relative "../types/article.rb"

module Query
  class Articles < GraphQL::Schema::Resolver
    description "list all Articles"

    type [Types::Article], null: true

    def resolve(**_args)
      GuardianContent::Content.search(
        nil,
        order: "newest",
        limit: 200,
        select: { fields: :all }
      )
    end
  end
end
