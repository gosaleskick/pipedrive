# frozen_string_literal: true

module Pipedrive
  class Result

    def initialize(data:, client: nil, endpoint: nil, params: nil)
      @data = data
      @client = client
      @endpoint = endpoint
      @params = params
    end

    def more_items
      pagination_data = data['additional_data']['pagination']
      return unless pagination_data['more_items_in_collection']
      params['start'] = pagination_data['start'] + pagination_data['limit']

      client.public_send(endpoint, params)
    end

    attr_reader :data, :client, :endpoint, :params
  end
end
