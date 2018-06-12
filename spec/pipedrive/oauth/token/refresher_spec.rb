# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::OAuth::Token::Refresher do
  let(:token) { TokenAR.new('old_token', "refresh_token", 1.day.ago, 'saleskick') }

  describe '#refresh' do
    context 'successful refresh' do
      it 'returns updated token' do
        new_token_attributes = {
          refresh_token: "new_refresh_token",
          access_token: "new_access_token",
          expires_at: Time.parse('Thu, 07 Jun 2018 09:12:51 GMT'),
          company_domain: 'saleskick'
        }

        VCR.use_cassette('token_refresher') do
          expect(described_class.new(token).refresh.to_h).to eq(new_token_attributes)
        end
      end
    end

    context 'unsuccessful refresh' do
      it 'raises an error' do
        VCR.use_cassette('invalid_refresh') do
          expect { described_class.new(token).refresh }.to raise_error Pipedrive::OAuth::Token::Refresher::RefreshError
        end
      end
    end
  end

  describe 'self.should_refresh?' do
    context 'old token' do
      it 'returns true' do
        expect(described_class.should_refresh?(token)).to eq(true)
      end
    end

    context 'new token' do
      let(:token) { OpenStruct.new(expires_at: 1.day.from_now) }

      it 'returns false' do
        expect(described_class.should_refresh?(token)).to eq(false)
      end
    end
  end
end
