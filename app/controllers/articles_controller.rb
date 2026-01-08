# frozen_string_literal: true

module GuardianLowData
  module Controllers
    module Articles
      class Show < Hanami::Action
        include Deps[guardian_service: "services.guardian_service"]

        def handle(request, response)
          id = request.params[:id]
          back_path = request.session[:request_path] || "/"
          query = request.session[:query]

          article = guardian_service.find_article(id)

          response.render(view, article: article, back_path: back_path, query: query)
        end
      end
    end
  end
end
