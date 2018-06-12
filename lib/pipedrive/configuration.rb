# frozen_string_literal: true

module Pipedrive
  class Configuration
    attr_accessor :client_id, :client_secret, :redirect_uri

    def initialize
      @client_id = nil
      @client_secret = nil
      @redirect_uri = nil
    end

    def basic_auth
      Base64.strict_encode64("#{client_id}:#{client_secret}")
    end
  end
end
