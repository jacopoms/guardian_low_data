require 'sinatra'
require "will_paginate/view_helpers/sinatra"
require 'will_paginate/array'
require_relative 'helpers'

class GuardianLowDataApp < Sinatra::Base
  register WillPaginate::Sinatra

  set :haml, :format => :html5
  set :logging, true
  set :server, %[puma]

  configure :development do
    set :bind, '0.0.0.0'
    set :port, 3000
    use BetterErrors::Middleware
    BetterErrors.application_root = File.expand_path('..', __FILE__)
  end

  helpers ApplicationHelper

  before do
    if defined?(GUARDIAN_CONTENT_API_KEY)
      GuardianContent.new(GUARDIAN_CONTENT_API_KEY)
    else
      GuardianContent.new(ENV['GUARDIAN_CONTENT_API_KEY'])
    end
  end

  get '/' do
    @page = 1
    @results = GuardianContent::Content.search(nil, order: 'newest', limit: 200, select: { fields: :all } ).paginate(:page => @page, :per_page => 10)
    haml :home
  end

  get '/page/:page' do
    @page = params[:page].to_i
    @results = GuardianContent::Content.search(nil, order: 'newest', page: @page, limit: 200, select: { fields: :all } ).paginate(:page => @page, :per_page => 10)
    haml :home
  end

  get '/article/*' do |id|
    @article = GuardianContent::Content.find_by_id(id)
    haml :article
  end
end
