require_relative 'custom_link_renderer'

module Sinatra
  module GuardianLowDataApp
    module Helpers
      def path_info
        '/' if request.path_info == '/search'
        request.path_info
      end
    end
  end
end
