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
    end
  end
end
