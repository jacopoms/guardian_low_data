# frozen_string_literal: true

module GuardianLowData
  module Actions
    module Home
      class Index < Hanami::Action
        include Deps[guardian_service: "services.guardian_service"]

        def handle(request, response)
          page = 1
          query = request.session[:query]

          articles = guardian_service.search_articles(query, page)

          response.render(view, articles: articles, page: page, query: query)
        end
      end
    end
  end
end
