# frozen_string_literal: true

require "graphql"
require_relative "queries/article.rb"
require_relative "queries/articles.rb"

class QueryRoot < GraphQL::Schema::Object
  graphql_name "QueryRoot"
  description "The query root of the Schema."

  field :articles, [Types::Article], resolver: Query::Articles, null: true do
    description "List all the articles"
  end

  field :article, Types::Article, resolver: Query::Article, null: true
end
