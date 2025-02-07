# frozen_string_literal: true

require 'sinatra'
require 'better_errors'
require 'will_paginate/view_helpers/sinatra'
require 'will_paginate/array'
# pull in the helpers and controllers
Dir.glob('./app/{helpers,controllers}/*.rb').each { |file| require file }
# :nodoc:

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
    set :port, 3000
    use BetterErrors::Middleware
    BetterErrors.application_root = File.expand_path(__dir__)
  end

  configure :production, :test do
    set :show_exceptions, false
    set :bind, '0.0.0.0'
    error do
      'Houston! We have a problem!!!'
    end
  end

  before do
    GuardianContent.new(ENV.fetch('GUARDIAN_CONTENT_API_KEY', nil))
  end
end
