require 'sinatra'
require 'better_errors'
require 'will_paginate/view_helpers/sinatra'
require 'will_paginate/array'
require 'sprockets'
require 'sass'
require_relative 'helpers'

class GuardianLowDataApp < Sinatra::Base
  register WillPaginate::Sinatra

  set :haml, :format => :html5
  set :logging, true
  set :server, %[thin]
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
    set :bind, '0.0.0.0'
    set :port, 3000
    use BetterErrors::Middleware
    BetterErrors.application_root = File.expand_path('..', __FILE__)
  end

  configure :production, :test do
    set :show_exceptions, false
    error do
      "Houston! We have a problem!!!"
    end
  end

  before do
    GuardianContent.new(ENV['GUARDIAN_CONTENT_API_KEY'])
  end

  # get assets
  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets", "")
    settings.sprockets_env.call(env)
  end

  get '/' do
    @page = 1
    session[:query] = nil
    @query = session[:query]
    set_path
    render_articles
  end

  get '/page/:page' do
    @page = params[:page].to_i
    @query = session[:query] ? session[:query] : nil
    set_path
    render_articles
  end

  get '/article/*' do |id|
    @back_path = session[:request_path]
    @query = session[:query] ? session[:query] : nil
    @article = GuardianContent::Content.find_by_id(id)
    haml :article
  end

  post '/search' do
    @page = 1
    session[:query] = params[:q].to_s
    @query = session[:query]
    render_articles
  end

  def prepare_articles(results)
    results = [OpenStruct.new(:title => "No Articles")] if results.empty?
    results
  end

  def render_articles
    results = GuardianContent::Content.search(@query, order: 'newest', limit: 200, select: { fields: :all } ).paginate(:page => @page, :per_page => 10)
    haml :home, locals: {:results => prepare_articles(results)}
  end

  def set_path
    session[:request_path] = path_info
  end
end
