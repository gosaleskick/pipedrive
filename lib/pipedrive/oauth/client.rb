# frozen_string_literal: true

module Pipedrive
  module OAuth
    class Client
      include Pipedrive::Endpoints::Users
      include Pipedrive::Endpoints::ActivityTypes
      include Pipedrive::Endpoints::Activities

      BASE_MARKET_API_URL = 'https://api-proxy.pipedrive.com'

      def initialize(token:)
        @token = token
      end

      private

      attr_reader :token

      def get_request(endpoint_path, params = {})
        refresh_token if Pipedrive::OAuth::Token::Refresher.should_refresh?(token)

        response = Typhoeus::Request.get(
          "#{BASE_MARKET_API_URL}#{endpoint_path}",
          params: params,
          headers: {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{token.access_token}"
          }
        )

        Oj.load(response.response_body, symbol_keys: true)
      end

      def refresh_token
        @token = Pipedrive::OAuth::Token::Refresher.new(token).refresh
      end
    end
  end
end
