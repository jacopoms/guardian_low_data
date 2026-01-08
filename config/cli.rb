# frozen_string_literal: true

Hanami.app.register_provider :cli do
  prepare do
    require "hanami/cli"
  end

  start do
    Hanami::CLI.new
  end
end
