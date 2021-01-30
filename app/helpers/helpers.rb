require_relative 'custom_link_renderer'

module Sinatra
  module GuardianLowDataApp
    module Helpers

      def path_info
        '/' if request.path_info == '/search'
        request.path_info
      end

      def render_articles(query = nil)
        @articles ||= GuardianContent::Content.search(
          query,
          order: 'newest',
          limit: 200,
          select: { fields: :all }
        ).paginate(page: @page, per_page: 10)
        p "articles = #{@articles}/n"
        haml :home, locals: { results: format_articles }
      end

      def set_path
        session[:request_path] = path_info
      end

      private

      attr_reader :articles

      def format_articles
        p "@articles #{@articles}}/n"
        if @articles.empty?
          [OpenStruct.new(title: 'No Articles')]
        else
          @articles
        end
      end
    end
  end
end
