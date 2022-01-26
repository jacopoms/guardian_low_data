# frozen_string_literal: true

class ApplicationController < Sinatra::Base
  set :views, File.expand_path('views', __dir__)

  get '/' do
    set_page
    set_query
    set_path
    render_articles
  end

  get '/page/:page' do |page|
    set_page(page)
    set_query(session[:query])
    set_path
    render_articles(@query)
  end

  get '/article/*' do |id|
    @back_path = session[:request_path]
    set_query(session[:query])
    @article = GuardianContent::Content.find_by_id(id)
    haml :article
  end

  post '/search' do
    set_query(params[:q])
    render_articles(@query)
  end

  private

  def set_query(query = nil)
    session[:query] = query
    @query = session[:query]
  end

  def set_page(page = 1)
    @page = page.to_i
  end
end
