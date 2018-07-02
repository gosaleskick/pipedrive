# frozen_string_literal: true

module Pipedrive
  module OAuth
    module Token
      class Base
        TOKEN_URL = 'https://oauth.pipedrive.com/oauth/token'

        private

        def token_attributes
          {
            company_domain: company_domain,
            encrypted_access_token: Pipedrive::Encryptor.encrypt(response_body[:access_token]),
            encrypted_refresh_token: Pipedrive::Encryptor.encrypt(response_body[:refresh_token]),
            expires_at: expires_at
          }
        end

        def expires_at
          @expires_at ||= Time.parse(response.headers['date']) + response_body[:expires_in].to_i
        end

        def company_domain
          raise NotImplementedError
        end

        def response
          raise NotImplementedError
        end

        def post_request(grant_type, params)
          Typhoeus::Request.post(
            TOKEN_URL,
            body: { grant_type: grant_type }.merge!(params),
            headers: {
              'Content-Type' => 'application/x-www-form-urlencoded',
              'Authorization' => "Basic #{basic_auth}"
            }
          )
        end

        def response_body
          @response_body ||= Oj.load(response.response_body, symbol_keys: true)
        end

        def basic_auth
          Pipedrive.configuration.basic_auth
        end
      end
    end
  end
end
