# frozen_string_literal: true

module GuardianLowData
  module Views
    module Home
      class Page < Hanami::View
        config.template = "home/index"
        config.layout = "application"

        expose :articles
        expose :page
        expose :query
      end
    end
  end
end
