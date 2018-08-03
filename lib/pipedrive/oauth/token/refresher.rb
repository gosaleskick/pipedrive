# frozen_string_literal: true

module Pipedrive
  module OAuth
    module Token
      class Refresher < Base
        class RefreshError < StandardError; end

        SAFE_REQUEST_MARGIN_IN_SECONDS = 10

        class << self
          def should_refresh?(token)
            token.expires_at <= Time.now.utc - SAFE_REQUEST_MARGIN_IN_SECONDS
          end
        end

        def initialize(token)
          @token = token
        end

        def refresh
          raise RefreshError, response_body[:message] unless response_body.fetch(:success, true)

          token.update(token_attributes)
          token
        end

        private

        attr_reader :token

        def response
          @response ||= post_request('refresh_token', { refresh_token: refresh_token })
        end

        def refresh_token
          Pipedrive::Encryptor.decrypt(token.encrypted_refresh_token)
        end

        def company_domain
          token.company_domain
        end

        def company_id
          token.company_id
        end
      end
    end
  end
end
