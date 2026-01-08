# frozen_string_literal: true

module GuardianLowData
  module Services
    class GuardianService
      def initialize
        @guardian_content = GuardianContent.new(ENV.fetch('GUARDIAN_CONTENT_API_KEY', nil))
      end

      def search_articles(query = nil, page = 1)
        articles = GuardianContent::Content.search(
          query,
          order: 'newest',
          limit: 200,
          select: { fields: :all }
        ).paginate(page: page, per_page: 10)

        return [EmptyResult.new(title: 'No Articles', total_pages: 0)] if articles.empty?

        articles
      end

      def find_article(id)
        GuardianContent::Content.find_by_id(id)
      end

      private

      EmptyResult = Struct.new(:title, :total_pages)
    end
  end
end
