# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::Endpoints::Users do
  let(:token) { OpenStruct.new(access_token: 'access_token', refresh_token: 'refresh_token', expires_at: 1.day.from_now) }
  let(:client) { Pipedrive::OAuth::Client.new(token: token) }

  describe 'GET /users' do
    it 'returns result object with json response' do
      VCR.use_cassette('users') do
        result = client.users

        expect(result).to be_a(Pipedrive::Result)
        expect(result.data).to match(
          {
            success: true,
            data: [
              {
                id: 5206648,
                name: "Matt Kozak",
                default_currency: "USD",
                locale: "en_US",
                lang: 1,
                email: "matt@saleskick.co",
                phone: nil,
                activated: true,
                last_login: "2018-06-06 12:30:01",
                created: "2018-05-30 06:09:43",
                modified: "2018-06-06 12:30:01",
                signup_flow_variation: nil,
                has_created_company: false,
                is_admin: 1,
                timezone_name: "Europe/Warsaw",
                timezone_offset: "+01:00",
                active_flag: true,
                role_id: 1,
                icon_url: "https://d3myhnqlqw2314.cloudfront.net/profile_120x120_5206648_6d20d82bb568e1a91144032018ca0f5f.jpg",
                is_you: true
              }
            ],
            additional_data:  {company_id: 3408256}
          }
        )
      end
    end
  end
end
