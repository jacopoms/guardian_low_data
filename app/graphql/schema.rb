require "graphql"
require_relative "query_root.rb"

class Schema < GraphQL::Schema
  query QueryRoot
end
