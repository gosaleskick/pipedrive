# frozen_string_literal: true

require "bundler/setup"
require "pipedrive"
require 'vcr'
require 'support/vcr'
require 'support/token_ar'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.expose_dsl_globally = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    Pipedrive.configure do |config|
      config.client_id = 'client_id'
      config.client_secret = 'client_secret'
      config.redirect_uri = 'test_redirect_uri'
      config.secret_encryption_key = "\xB2\x9Dx\xF8\x12\x8B\xEF\xD9\xFA\x94\x8D\x1C\xCA \xEE\"xo,\xBEn\x93)\xB2\xFD\xDE\x87cA\xF9j\a"
    end
  end
end
