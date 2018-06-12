# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::OAuth::Token::Fetcher do
  describe '#fetch' do
    let(:instance) { described_class.new(code) }

    context 'invalid token' do
      let(:code) { 'invalid_code' }

      it 'raises an error' do
        VCR.use_cassette('token/invalid_fetchr') do
          expect { instance.fetch }
            .to raise_error Pipedrive::OAuth::Token::Fetcher::FetchTokenError
        end
      end
    end

    context 'valid token' do
      let(:code) { 'valid_code' }

      it 'returns hash with token attributes', :vcr do
        expect(instance.fetch).to match(
          access_token: "access_token",
          company_domain: "crazy-test-sandbox",
          expires_at: Time.parse('Tue, 12 Jun 2018 12:01:15 GMT'),
          refresh_token: "refresh_token"
        )
      end
    end
  end
end
