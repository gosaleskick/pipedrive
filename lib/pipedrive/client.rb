# frozen_string_literal: true

module Pipedrive
  class Client
    include Pipedrive::Endpoints::Users
    include Pipedrive::Endpoints::ActivityTypes
    include Pipedrive::Endpoints::Activities

    BASE_MARKET_API_URL = 'https://api-proxy.pipedrive.com'

    def initialize(token:, client_id:, client_secret:)
      @token         = token
      @basic_auth    = Base64.strict_encode64("#{client_id}:#{client_secret}")
      puts basic_auth
    end

    private

    attr_reader :token, :basic_auth

    def get_request(endpoint_path, params = {})
      puts token_refresher.should_refresh?(token)
      refresh_token if token_refresher.should_refresh?(token)

      response = Typhoeus::Request.get(
        "#{BASE_MARKET_API_URL}#{endpoint_path}",
        params: params,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer #{token.access_token}"
        }
      )

      Oj.load(response.response_body)
    end

    def refresh_token
      @token = token_refresher.refresh(token)
    end

    def token_refresher
      @token_refresher ||= Pipedrive::Token::Refresher.new(basic_auth: basic_auth)
    end
  end
end
