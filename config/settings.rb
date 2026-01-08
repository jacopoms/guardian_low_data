# frozen_string_literal: true

module GuardianLowData
  class Settings < Hanami::Settings
    setting :guardian_content_api_key, constructor: Types::String.optional.default { ENV.fetch("GUARDIAN_CONTENT_API_KEY", nil) }
    setting :session_secret, constructor: Types::String.default { ENV.fetch("SESSION_SECRET", "guardian_low_data_secret") }
  end
end
