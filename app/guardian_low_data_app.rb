require 'sinatra'
require "will_paginate/view_helpers/sinatra"
require 'will_paginate/array'
require_relative 'helpers'

class GuardianLowDataApp < Sinatra::Base
  register WillPaginate::Sinatra

  set :haml, :format => :html5
  set :logging, true
  set :server, %[puma]
  enable :sessions

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
    session[:query] = nil
    @query = session[:query]
    @results = GuardianContent::Content.search(nil, order: 'newest', limit: 200, select: { fields: :all } ).paginate(:page => @page, :per_page => 10)
    session[:request_path] = path_info
    haml :home
  end

  get '/page/:page' do
    @page = params[:page].to_i
    @query = session[:query] ? session[:query] : nil
    @results = GuardianContent::Content.search(@query, order: 'newest', limit: 200, select: { fields: :all } ).paginate(:page => @page, :per_page => 10)
    session[:request_path] = path_info
    haml :home
  end

  get '/article/*' do |id|
    @back_path = session[:request_path]
    @article = GuardianContent::Content.find_by_id(id)
    haml :article
  end

  post '/search' do
    @page = 1
    session[:query] = params[:q].to_s
    @query = session[:query]
    @results = GuardianContent::Content.search(@query, order: 'newest', limit: 200, select: { fields: :all } ).paginate(:page => @page, :per_page => 10)
    haml :home
  end
end
