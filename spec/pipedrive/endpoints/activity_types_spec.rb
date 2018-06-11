# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::Endpoints::ActivityTypes do
  let(:token) { OpenStruct.new(access_token: 'access_token', refresh_token: 'refresh_token', expires_at: 1.day.from_now) }
  let(:client) { Pipedrive::OAuth::Client.new(token: token) }

  describe 'GET activity_types' do
    it 'returns result object with json response' do
      VCR.use_cassette('activity_types') do
        result = client.activity_types

        expect(result).to be_a(Pipedrive::Result)
        expect(result.data).to match(
          {
            success: true,
            data: [
              {
                id: 1,
                order_nr: 1,
                name: "Call",
                key_string: "call",
                icon_key: "call",
                active_flag: true,
                color: nil,
                is_custom_flag: false,
                add_time: "2018-05-29 11:59:18",
                update_time: nil
              }, {
                id: 2,
                order_nr: 2,
                name: "Meeting",
                key_string: "meeting",
                icon_key: "meeting",
                active_flag: true,
                color: nil,
                is_custom_flag: false,
                add_time: "2018-05-29 11:59:18",
                update_time: nil
              }, {
                id: 3,
                order_nr: 3,
                name: "Task",
                key_string: "task",
                icon_key: "task",
                active_flag: true,
                color: nil,
                is_custom_flag: false,
                add_time: "2018-05-29 11:59:18",
                update_time: nil
              }, {
                id: 4,
                order_nr: 4,
                name: "Deadline",
                key_string: "deadline",
                icon_key: "deadline",
                active_flag: true,
                color: nil,
                is_custom_flag: false,
                add_time: "2018-05-29 11:59:18",
                update_time: nil
              }, {
                id: 5,
                order_nr: 5,
                name: "Email",
                key_string: "email",
                icon_key: "email",
                active_flag: true,
                color: nil,
                is_custom_flag: false,
                add_time: "2018-05-29 11:59:18",
                update_time: nil
              }, {
                id: 6,
                order_nr: 6,
                name: "Lunch",
                key_string: "lunch",
                icon_key: "lunch",
                active_flag: true,
                color: nil,
                is_custom_flag: false,
                add_time: "2018-05-29 11:59:18",
                update_time: nil
              }
            ]
          }
        )
      end
    end
  end
end
