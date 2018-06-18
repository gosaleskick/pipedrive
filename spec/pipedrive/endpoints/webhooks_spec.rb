# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::Endpoints::Webhooks do
  let(:token) { OpenStruct.new(access_token: 'access_token', expires_at: 1.day.from_now) }
  let(:client) { Pipedrive::OAuth::Client.new(token: token) }

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
