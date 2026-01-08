# frozen_string_literal: true

require "bundler/setup"
require "hanami/prepare"

# Load the application
require_relative "app"
require_relative "routes"
require_relative "settings"
require_relative "providers"
require_relative "web"
require_relative "cli"
require_relative "assets"

# Load helpers
require_relative "../app/helpers/custom_link_renderer"
