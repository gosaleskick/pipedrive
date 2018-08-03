# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::OAuth::Token::Fetcher do
  describe '#fetch' do
    let(:instance) { described_class.new(code) }

    context 'invalid token' do
      let(:code) { 'invalid_code' }

      it 'raises an error' do
        VCR.use_cassette('token/invalid_fetch') do
          expect { instance.fetch }
            .to raise_error Pipedrive::OAuth::Token::Fetcher::FetchTokenError
        end
      end
    end

    context 'valid token' do
      let(:code) { 'valid_code' }

      subject { instance.fetch }

      it 'returns hash with token attributes', :vcr do
        expect(Pipedrive::OAuth::Token::Refresher).to receive(:should_refresh?).and_return(false)
        expect(subject).to match(
          company_domain: "crazy-test-sandbox",
          company_id: 3412845,
          encrypted_access_token: be_a(String),
          encrypted_refresh_token: be_a(String),
          expires_at: Time.parse('Tue, 12 Jun 2018 12:01:15 GMT')
        )
        expect(Pipedrive::Encryptor.decrypt(subject[:encrypted_access_token])).to eq('access_token')
        expect(Pipedrive::Encryptor.decrypt(subject[:encrypted_refresh_token])).to eq('refresh_token')
      end
    end
  end
end
