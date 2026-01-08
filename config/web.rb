# frozen_string_literal: true

Hanami.app.register_provider :web do
  prepare do
    require "hanami/web"
  end

  start do
    Hanami::Web.new
  end
end
