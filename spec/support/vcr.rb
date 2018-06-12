# frozen_string_literal: true

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :typhoeus
  c.configure_rspec_metadata!
end
