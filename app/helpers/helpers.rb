# frozen_string_literal: true

require_relative "custom_link_renderer"

module Sinatra
  module GuardianLowDataApp
    module Helpers
      def path_info
        "/" if request.path_info == "/search"
        request.path_info
      end

      def prepare_articles(results)
        if results.empty?
          [OpenStruct.new(title: "No Articles")]
        else
          results
        end
      end

      def render_articles(query = nil)
        articles = GuardianContent::Content.search(
          query,
          order: "newest",
          limit: 200,
          select: { fields: :all }
        ).paginate(page: @page, per_page: 10)
        haml :home, locals: { results: prepare_articles(articles) }
      end

      def set_path
        session[:request_path] = path_info
      end
    end
  end
end
