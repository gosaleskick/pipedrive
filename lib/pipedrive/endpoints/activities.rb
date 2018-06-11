# frozen_string_literal: true

module Pipedrive
  module Endpoints
    module Activities
      MAX_LIMIT = 500
      ALL_USERS_ID = 0
      def activities(params = {})
        params[:limit] ||= MAX_LIMIT
        params[:user_id] ||= ALL_USERS_ID
        params[:start] ||= 0

        Pipedrive::Result.new(data: get_request('/activities', params), client: self, endpoint: :activities, params: params)
      end
    end
  end
end
