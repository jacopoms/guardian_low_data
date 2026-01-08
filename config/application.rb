# frozen_string_literal: true

require "hanami"
require "logger"

module GuardianLowData
  class Application < Hanami::Application
    config.actions.sessions = :cookie, secret: ENV.fetch("SESSION_SECRET", "guardian_low_data_secret")

    # Configure middleware
    config.middleware.use Rack::Static, urls: ["/public"], root: "public"

    # Configure views
    config.views.paths = [File.join(__dir__, "../app/templates")]
    config.views.layout = "application"

    # Configure assets
    config.assets.paths = [File.join(__dir__, "../public")]

    # Configure actions
    config.actions.default_format = :html

    # Configure sessions
    config.sessions = :cookie, secret: ENV.fetch("SESSION_SECRET", "guardian_low_data_secret")

    # Configure logging
    config.logger.level = :info

    # Configure environment
    config.environment = ENV.fetch("HANAMI_ENV", "development")

    # Configure public folder
    config.public_folder = "public"

    # Configure server
    config.server = :puma

    # Configure port
    config.port = ENV.fetch("PORT", 4000)

    # Configure host
    config.host = "0.0.0.0"

    # Configure templates
    config.templates.paths = [File.join(__dir__, "../app/templates")]

    # Configure layout
    config.layout = "application"

    # Configure default format
    config.default_format = :html

    # Configure root
    config.root = File.expand_path("..", __dir__)

    # Configure inflections
    config.inflections do
      inflect.irregular "criterion", "criteria"
    end

    # Configure timezone
    config.timezone = "UTC"

    # Configure logger
    config.logger = Logger.new($stdout)

    # Configure error handling
    config.handle_exceptions = true

    # Configure security
    config.security.x_frame_options = "DENY"
    config.security.x_content_type_options = "nosniff"
    config.security.x_xss_protection = "1; mode=block"

    # Configure cookies
    config.cookies.enabled = true
    config.cookies.secure = false
    config.cookies.http_only = true

    # Configure sessions
    config.sessions.enabled = true
    config.sessions.secret = ENV.fetch("SESSION_SECRET", "guardian_low_data_secret")

    environment(:development) do
      # Development-specific configuration
      config.logger.level = :debug
    end

    environment(:test) do
      # Test-specific configuration
      config.logger.level = :debug
    end

    environment(:production) do
      # Production-specific configuration
      config.logger.level = :info
    end
  end
end
