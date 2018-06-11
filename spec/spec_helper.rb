# frozen_string_literal: true

require "bundler/setup"
require "pipedrive"
require 'vcr'
require 'support/vcr'

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
    end
  end
end
