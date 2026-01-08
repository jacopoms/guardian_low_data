# frozen_string_literal: true

# Initialize Guardian Content API
if ENV['GUARDIAN_CONTENT_API_KEY']
  GuardianContent.new(ENV.fetch('GUARDIAN_CONTENT_API_KEY', nil))
end
