# frozen_string_literal: true

module GuardianLowData
  module Views
    module Articles
      class Show < Hanami::View
        config.template = "articles/show"
        config.layout = "application"

        expose :article
        expose :back_path
        expose :query
      end
    end
  end
end
