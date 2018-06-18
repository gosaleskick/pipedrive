# frozen_string_literal: true

module Pipedrive
  module Endpoints
    module Webhooks
      ALL_EVENTS = '*'

      def create_webhook(**body)
        raise Pipedrive::Connection::MissingParameter, 'subscription_url is required' unless body[:subscription_url]

        body[:user_id] ||= admin_user_id
        body[:event_action] ||= ALL_EVENTS
        body[:event_object] ||= ALL_EVENTS

        Pipedrive::Result.new(data: post('/webhooks', body))
      end

      private

      def admin_user_id
        users.data[:data].find { |user| user[:is_admin] == 1 }&.fetch(:id, nil)
      end
    end
  end
end
