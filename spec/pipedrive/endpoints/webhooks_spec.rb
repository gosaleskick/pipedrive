# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::Endpoints::Webhooks do
  let(:token) { TokenAR.new }
  let(:client) { Pipedrive::OAuth::Client.new(token: token) }

  describe 'GET /webhooks' do
    subject { client.webhooks }

    it 'returns result object with json response', :vcr do
      expect(subject).to be_a(Pipedrive::Result)
      expect(subject.data).to match({
        data: [
          {
            id: 22679,
            company_id: 3486667,
            owner_id: 5323730,
            user_id: 5323730,
            event_action: "*",
            event_object: "*",
            subscription_url: "https://webhook.site/4e61fc8f-276c-49cb-954c-f0e62a8815c3",
            is_active: 1,
            add_time: "2018-06-18T09:49:21.000Z",
            remove_time: nil,
            type: "general",
            http_auth_user: nil,
            http_auth_password: nil,
            additional_data: {},
            last_delivery_time: "2018-06-18T14:23:00.395Z",
            last_http_status: 200,
            admin_id: 5323730
          }, {
            id: 22733,
            company_id: 3486667,
            owner_id: 5323730,
            user_id: 5323730,
            event_action: "updated",
            event_object: "activity",
            subscription_url: "https://webhook.site/4e61fc8f-276c-49cb-954c-f0e62a8815c3",
            is_active: 1,
            add_time: "2018-06-18T14:22:38.000Z",
            remove_time: nil,
            type: "general",
            http_auth_user: nil,
            http_auth_password: nil,
            additional_data: {},
            last_delivery_time: "2018-06-18T14:23:00.374Z",
            last_http_status: 200,
            admin_id: 5323730
          }
        ],
        status: "ok",
        success: true
      })
    end
  end

  describe 'POST /webhooks' do
    subject { client.create_webhook(body) }

    context 'subscription_url only' do
      let(:body) { { subscription_url: 'https://webhook.site/4e61fc8f-276c-49cb-954c-f0e62a8815c3' } }

      it 'returns result object with json response', :vcr do
        expect(subject).to be_a(Pipedrive::Result)
        expect(subject.data).to match({
          "status": "ok",
          "success": true,
          "data": {
            "id": 22706,
            "company_id": 3486667,
            "owner_id": 5323730,
            "user_id": 5323730,
            "event_action": "*",
            "event_object": "*",
            "subscription_url": "https://webhook.site/4e61fc8f-276c-49cb-954c-f0e62a8815c3",
            "is_active": 1,
            "add_time": "2018-06-18T11:07:35.000Z",
            "remove_time": nil,
            "type": "application",
            "http_auth_user": nil,
            "http_auth_password": nil,
            "additional_data": {}
          }
        })
      end
    end

    context 'subscription_url is undefined' do
      let(:body) { {} }

      it 'raises an error' do
        expect { subject }.to raise_error Pipedrive::Connection::MissingParameter
      end
    end
  end
end
