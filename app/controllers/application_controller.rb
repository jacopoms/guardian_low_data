# frozen_string_literal: true

require "sinatra/json"
require "rack/contrib"
require_relative "../graphql/schema.rb"

class ApplicationController < Sinatra::Base
  use Rack::PostBodyContentTypeParser

  get "/" do
    @page = 1
    session[:query] = nil
    @query = session[:query]
    set_path
    render_articles
  end

  get "/page/:page" do
    @page = params[:page].to_i
    @query = session[:query] || nil
    set_path
    render_articles(@query)
  end

  get "/article/*" do |id|
    @back_path = session[:request_path]
    @query = session[:query] || nil
    @article = GuardianContent::Content.find_by_id(id)
    haml :article
  end

  post "/search" do
    @page = 1
    session[:query] = params[:q].to_s
    @query = session[:query]
    render_articles(@query)
  end

  post "/graphql" do
    binding.pry
    result = Schema.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil }
    )

    json result
  end
end
