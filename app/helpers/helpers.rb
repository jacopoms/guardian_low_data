# frozen_string_literal: true

require_relative 'custom_link_renderer'

module Helpers
  def path_info
    # Ruby 4.0.0: Logical operator line continuation feature
    return '/' if request.path_info == '/search'

    request.path_info
  end

  def render_articles(query = nil)
    search_articles(query)

    haml :home, locals: { results: return_articles }
  end

  def set_path
    session[:request_path] = path_info
  end

  private

  EmptyResult = Struct.new(:title, :total_pages) do
    # Ruby 4.0.0: Customize inspect output to exclude internal state
    def instance_variables_to_inspect
      []
    end
  end

  attr_reader :articles

  def search_articles(query)
    @articles = GuardianContent::Content.search(
      query,
      order: 'newest',
      limit: 200,
      select: { fields: :all }
    ).paginate(page: @page, per_page: 10)
  end

  def return_articles
    return [EmptyResult.new(title: 'No Articles', total_pages: 0)] if @articles.empty?

    @articles
  end
end
