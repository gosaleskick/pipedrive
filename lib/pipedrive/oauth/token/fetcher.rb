# frozen_string_literal: true

module Pipedrive
  module OAuth
    module Token
      class Fetcher < Base
        class FetchTokenError < StandardError; end

        def initialize(code)
          @code = code
        end

        def fetch
          raise FetchTokenError, response_body[:message] unless response_body.fetch(:success, true)

          token_attributes
        end

        private

        attr_reader :code

        def response
          @response ||= post_request('authorization_code', { code: code, redirect_uri: redirect_uri })
        end

        def redirect_uri
          Pipedrive.configuration.redirect_uri
        end

        def company_domain
          token = OpenStruct.new(
            encrypted_access_token: Pipedrive::Encryptor.encrypt(response_body[:access_token]),
            expires_at: expires_at
          )
          client = Pipedrive::OAuth::Client.new(token: token)

          client.users_me.data[:data][:company_domain]
        end
      end
    end
  end
end
