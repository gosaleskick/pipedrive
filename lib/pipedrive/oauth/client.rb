# frozen_string_literal: true

module Pipedrive
  module OAuth
    class Client
      include Pipedrive::Endpoints::Users
      include Pipedrive::Endpoints::ActivityTypes
      include Pipedrive::Endpoints::Activities
      include Pipedrive::Endpoints::Webhooks
      include Pipedrive::Connection

      def initialize(token:)
        @token = token
      end

      private

      attr_reader :token
    end
  end
end
