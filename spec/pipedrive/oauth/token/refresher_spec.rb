# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::OAuth::Token::Refresher do
  let(:refresher) { described_class.new }
  let(:token) { OpenStruct.new(access_token: 'access_token', refresh_token: "refresh_token", expires_at: 1.day.ago) }

  describe '#refresh' do
    context 'unsuccessful refresh' do
      it 'raises an error' do
        VCR.use_cassette('invalid_refresh') do
          expect { refresher.refresh(token) }.to raise_error Pipedrive::OAuth::Token::Refresher::RefreshError
        end
      end
    end
  end

  describe '#should_refresh?' do
    context 'old token' do
      it 'returns true' do
        expect(refresher.should_refresh?(token)).to eq(true)
      end
    end

    context 'new token' do
      let(:token) { OpenStruct.new(expires_at: 1.day.from_now) }

      it 'returns false' do
        expect(refresher.should_refresh?(token)).to eq(false)
      end
    end
  end
end
