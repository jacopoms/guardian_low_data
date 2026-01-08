# frozen_string_literal: true

module GuardianLowData
  class Routes < Hanami::Routes
    root to: "home.index"

    get "/page/:page", to: "home.page"
    get "/article/*id", to: "articles.show"
    post "/search", to: "home.search"
  end
end
