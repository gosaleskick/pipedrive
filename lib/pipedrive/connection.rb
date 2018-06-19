# frozen_string_literal: true

module Pipedrive
  module Connection
    class MissingParameter < StandardError; end

    BASE_MARKET_API_URL = 'https://api-proxy.pipedrive.com'

    private

    def get(endpoint_path, **params)
      request(:get, endpoint_path, params)
    end

    def post(endpoint_path, **body)
      request(:post, endpoint_path, body)
    end

    def request(method, endpoint_path, **params)
      body = method == :get ? nil : Oj.dump(params, mode: :compat)
      params = body ? nil : params

      refresh_token

      response = Typhoeus::Request.new(
        "#{BASE_MARKET_API_URL}#{endpoint_path}",
        method: method,
        body: body,
        params: params,
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{token.access_token}"
        }
      ).run

      Oj.load(response.response_body, symbol_keys: true, mode: :strict)
    end

    def refresh_token
      return unless Pipedrive::OAuth::Token::Refresher.should_refresh?(token)

      @token = Pipedrive::OAuth::Token::Refresher.new(token).refresh
    end
  end
end
