# frozen_string_literal: true

Hanami.app.register_provider :guardian_service do
  prepare do
    require "guardian_low_data/services/guardian_service"
  end

  start do
    register "services.guardian_service", GuardianLowData::Services::GuardianService.new
  end
end
