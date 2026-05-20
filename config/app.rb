# frozen_string_literal: true

require 'sinatra'
require 'better_errors'
require 'rack/cache'
require 'will_paginate/view_helpers/sinatra'
require 'will_paginate/array'
# pull in the helpers and controllers
Dir.glob('./app/{helpers,controllers}/*.rb').each { |file| require file }
# Sinatra application wiring and environment-specific configuration.
class GuardianLowDataApp < ApplicationController
  register WillPaginate::Sinatra

  set :haml, format: :html5
  set :logging, true
  set :server, %(thin)
  set :views, File.expand_path('../app/views', __dir__)
  set :public_folder, 'public'
  enable :sessions

  configure :development do
    set :bind, '0.0.0.0'
    # Ruby 4.0.4: Logical operator line continuation feature allows
    # operators at line start to continue previous line
    set :port, ENV['PORT'] || 4000
    use BetterErrors::Middleware
    BetterErrors.application_root = File.expand_path(__dir__)

    # Rack::Cache for development (verbose logging)
    use Rack::Cache,
        verbose: true,
        metastore: 'file:tmp/cache/rack/meta',
        entitystore: 'file:tmp/cache/rack/body'
  end

  configure :production do
    set :show_exceptions, false
    set :bind, '0.0.0.0'

    # Rack::Cache for production
    use Rack::Cache,
        verbose: false,
        metastore: 'file:tmp/cache/rack/meta',
        entitystore: 'file:tmp/cache/rack/body'

    error do
      'Houston! We have a problem!!!'
    end
  end

  configure :test do
    set :show_exceptions, false
    set :bind, '0.0.0.0'
    # No caching in test environment
    error do
      'Houston! We have a problem!!!'
    end
  end

  before do
    GuardianContent.new(ENV.fetch('GUARDIAN_CONTENT_API_KEY', nil))
  end
end
