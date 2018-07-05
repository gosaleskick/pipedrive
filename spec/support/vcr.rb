# frozen_string_literal: true

VCR.configure do |c|
  c.default_cassette_options = { match_requests_on: [:method, :uri, :body] }
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :typhoeus
  c.configure_rspec_metadata!
end
