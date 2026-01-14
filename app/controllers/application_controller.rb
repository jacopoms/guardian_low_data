# frozen_string_literal: true

# Main Controller of the application
#
class ApplicationController < Sinatra::Base
  set :views, File.expand_path('views', __dir__)
  helpers Helpers

  # Cache configuration
  CACHE_TTL = 300 # 5 minutes in seconds

  get '/' do
    cache_control :public, max_age: CACHE_TTL
    page
    query
    set_path
    render_articles
  end

  get '/page/:page' do |page_num|
    cache_control :public, max_age: CACHE_TTL
    page(page_num)
    query(session[:query])
    set_path
    render_articles(@query)
  end

  get '/article/*' do |id|
    cache_control :public, max_age: CACHE_TTL
    @back_path = session[:request_path]
    query(session[:query])
    # Ruby 4.0.0: Array#find is now optimized for better performance
    # (though here we're using Content.find_by_id which is a different method)
    @article = GuardianContent::Content.find_by_id(id)
    haml :article
  end

  post '/search' do
    # POST requests are not cached
    query(params[:q])
    render_articles(@query)
  end

  private

  def query(query = nil)
    session[:query] = query
    @query = session[:query]
  end

  def page(page = 1)
    @page = page.to_i
  end
end
