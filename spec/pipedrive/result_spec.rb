require 'spec_helper'

RSpec.describe Pipedrive::Result do
  describe 'more_items' do
    it 'returns nil when more_items_in_collection is false' do
      response_data = { additional_data: { pagination: { more_items_in_collection: false } } }
      result = Pipedrive::Result.new(data: response_data)

      expect(result.more_items).to eq nil
    end
  end
end
