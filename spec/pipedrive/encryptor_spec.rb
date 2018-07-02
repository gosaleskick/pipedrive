# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::Encryptor do
  let(:string) { 'message' }

  it 'can decrypt encrypted msg' do
    encrypted_message = described_class.encrypt(string)

    expect(described_class.decrypt(encrypted_message)).to eq(string)
  end
end
