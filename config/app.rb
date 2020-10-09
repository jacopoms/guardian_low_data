# frozen_string_literal: true

require "sinatra"
require "better_errors"
require "will_paginate/view_helpers/sinatra"
require "will_paginate/array"
require "sprockets"
require "sass"
require "graphql"
# pull in the helpers and controllers
Dir.glob("./app/**/*.rb").sort.each(&method(:require))
# :nodoc:

class GuardianLowDataApp < ApplicationController
  register WillPaginate::Sinatra

  set :haml, format: :html5
  set :logging, true
  set :server, %(thin)
  set :views, File.expand_path("../app/views", __dir__)

  enable :sessions
  helpers Sinatra::GuardianLowDataApp::Helpers

  configure do
    set :sprockets_env, Sprockets::Environment.new # initialize new sprockets environment
  end
  # append assets paths
  settings.sprockets_env.append_path "app/assets/stylesheets"

  # compress assets
  settings.sprockets_env.css_compressor = :scss

  configure :development do
    set :bind, "0.0.0.0"
    set :port, 3000
    use BetterErrors::Middleware
    BetterErrors.application_root = File.expand_path(__dir__)
  end

  configure :production, :test do
    set :show_exceptions, false
    error do
      "Houston! We have a problem!!!"
    end
  end

  before do
    GuardianContent.new(ENV["GUARDIAN_CONTENT_API_KEY"])
  end

  # get assets
  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets", "")
    settings.sprockets_env.call(env)
  end
end
