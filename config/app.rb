# frozen_string_literal: true

require "hanami"

module GuardianLowData
  class Application < Hanami::App
    # Minimal configuration for Hanami 2.2

    # Implement Rack interface
    def call(env)
      # For now, return a simple response to test
      [200, {"Content-Type" => "text/html"}, ["Hello from Guardian Low Data!"]]
    end
  end
end
