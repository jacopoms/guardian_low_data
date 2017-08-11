# frozen_string_literal: true
source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'sinatra'
gem 'puma'
gem 'dotenv'
gem 'guardian-content', :github => 'rob-murray/contentapi-ruby'
gem 'haml'
gem 'pry-byebug'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'rake'
  gem 'rack-test'
end
