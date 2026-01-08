# frozen_string_literal: true

source 'https://rubygems.org'
ruby '3.4.2'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'hanami', '~> 2.2'
gem 'hanami-router', '~> 2.2'
gem 'hanami-controller', '~> 2.2'
gem 'hanami-view', '~> 2.2'
gem 'hanami-validations', '~> 2.2'
gem 'hanami-utils', '~> 2.2'
gem 'hanami-cli', '~> 2.2'
gem 'hanami-rspec', '~> 2.2'
gem 'hanami-webconsole', '~> 2.2', group: :development

gem 'guardian-content', github: 'jacopoms/contentapi-ruby'
gem 'will_paginate', '~> 3.1.1'
gem 'dotenv'
gem 'puma'

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
