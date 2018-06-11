require 'spec_helper'

RSpec.describe Pipedrive::OAuth::Client do
  describe 'token refreshing' do
    class TokenAR < Struct.new(:access_token, :refresh_token, :expires_at)
      def update(access_token:, refresh_token:, expires_at:)
        self.access_token = access_token
        self.refresh_token = refresh_token
        self.expires_at = expires_at

        true
      end
    end

    let(:token) { TokenAR.new('old_token', "refresh_token", 1.day.ago) }
    let(:client) { Pipedrive::OAuth::Client.new(token: token) }

    it 'uses new token to send request' do
      new_token_attributes = {
          refresh_token: "new_refresh_token",
          access_token: "new_access_token",
          expires_at: Time.parse('Thu, 07 Jun 2018 09:12:51 GMT')
      }

      VCR.use_cassette('token_refresher', match_requests_on: [:method, :uri, :headers]) do
        expect(client.users.data).to match(
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
            additional_data: {company_id: 3408256}
          }
        )
      end
    end
  end
end
