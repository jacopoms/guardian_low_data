# frozen_string_literal: true

Hanami.app.register_provider :assets do
  prepare do
    require "hanami/assets"
  end

  start do
    Hanami::Assets.new
  end
end
