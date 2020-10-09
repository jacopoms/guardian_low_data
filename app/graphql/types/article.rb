# frozen_string_literal: true

require "graphql"

module Types
  class Article < GraphQL::Schema::Object
    description "An Article"

    field :id, ID, null: false
    field :title, String, null: false
  end
end
