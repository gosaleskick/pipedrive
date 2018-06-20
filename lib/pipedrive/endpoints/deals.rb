# frozen_string_literal: true

module Pipedrive
  module Endpoints
    module Deals
      MAX_LIMIT = 500

      def deals(**params)
        params[:start] ||= 0
        params[:limit] ||= MAX_LIMIT

        Pipedrive::Result.new(data: get('/deals', params), client: self, endpoint: :deals, params: params)
      end

      def deals_timeline(**params)
        raise Pipedrive::Connection::MissingParameter, 'start_date is required' unless params[:start_date]
        raise Pipedrive::Connection::MissingParameter, 'interval is required' unless params[:interval]
        raise Pipedrive::Connection::MissingParameter, 'amount is required' unless params[:amount]
        raise Pipedrive::Connection::MissingParameter, 'field_key is required' unless params[:field_key]

        Pipedrive::Result.new(data: get('/deals/timeline', params))
      end
    end
  end
end
