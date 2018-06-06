# frozen_string_literal: true

module Pipedrive
  module Token
    class Refresher
      REFRESH_TOKEN_URL = 'https://oauth.pipedrive.com/oauth/token'
      SAFE_REQUEST_MARGIN_IN_SECONDS = 10
      def initialize(basic_auth:)
        @basic_auth = basic_auth
      end

      def should_refresh?(token_data)
        token_data.expires_at <= Time.now.utc - SAFE_REQUEST_MARGIN_IN_SECONDS
      end

      def refresh(token_data)
        response = refresh_token_request(token_data.refresh_token)
        response_body = response.response_body
        puts response_body

        expires_at = Time.parse(response.headers['date']) + response_body['expires_in'].to_i
        new_attributes = {
          refresh_token: response_body['refresh_token'],
          access_token: response_body['access_token'],
          expires_at: expires_at
        }

        token_data.update_attributes(new_attributes)
      end

      private

      attr_reader :basic_auth

      def refresh_token_request(refresh_token)
        Typhoeus::Request.post(
          REFRESH_TOKEN_URL,
          body: { grant_type: 'refresh_token', refresh_token: refresh_token },
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': "Basic #{basic_auth}"
          }
        )
      end
    end
  end
end
