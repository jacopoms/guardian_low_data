# frozen_string_literal: true

source 'https://rubygems.org'
ruby '3.2.0'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'better_errors'
gem 'binding_of_caller'
gem 'dotenv'
gem 'guardian-content', github: 'jacopoms/contentapi-ruby'
gem 'haml'
gem 'sinatra'
gem 'thin'
gem 'will_paginate', '~> 3.1.1'

group :development do
  gem 'irb'
  gem 'rubocop'
  gem 'ruby-lsp'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'reek'
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
end

group :test do
  gem 'rack-test'
  gem 'rake'
  gem 'rspec'
  gem 'vcr'
  gem 'webmock'
end
