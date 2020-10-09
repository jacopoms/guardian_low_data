# frozen_string_literal: true

source "https://rubygems.org"
ruby "2.6.3"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "better_errors"
gem "binding_of_caller"
gem "dotenv"
gem "graphql"
gem "guardian-content", github: "Jackopo/contentapi-ruby"
gem "haml"
gem "pry-byebug"
gem "rack-contrib"
gem "sass"
gem "sinatra"
gem "sinatra-contrib"
gem "sprockets"
gem "thin"
gem "will_paginate", "~> 3.1.1"

group :development do
  gem "rubocop", require: false
  gem "solargraph"
end

group :test do
  gem "minitest"
  gem "rack-test"
  gem "rake"
  gem "rspec"
  gem "vcr"
  gem "webmock"
end
