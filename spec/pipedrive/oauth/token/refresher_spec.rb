# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::OAuth::Token::Refresher do
  let(:token) { TokenAR.new(expires_at: 1.day.ago) }

  describe '#refresh' do
    context 'successful refresh' do
      it 'returns updated token' do
        VCR.use_cassette('token_refresher') do
          updated_token = described_class.new(token).refresh

          expect(updated_token.company_domain).to eq('saleskick')
          expect(updated_token.company_id).to eq('company_id')
          expect(updated_token.expires_at).to eq(Time.parse('Thu, 07 Jun 2018 09:12:51 GMT'))
          expect(Pipedrive::Encryptor.decrypt(updated_token.encrypted_access_token)).to eq('new_access_token')
          expect(Pipedrive::Encryptor.decrypt(updated_token.encrypted_refresh_token)).to eq('new_refresh_token')
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
