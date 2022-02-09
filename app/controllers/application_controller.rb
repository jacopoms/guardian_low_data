# frozen_string_literal: true

class ApplicationController < Sinatra::Base
  set :views, File.expand_path('views', __dir__)

  get '/' do
    page
    query
    set_path
    render_articles
  end

  get '/page/:page' do |page|
    page(page)
    query(session[:query])
    set_path
    render_articles(@query)
  end

  get '/article/*' do |id|
    @back_path = session[:request_path]
    query(session[:query])
    @article = GuardianContent::Content.find_by_id(id)
    haml :article
  end

  post '/search' do
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
