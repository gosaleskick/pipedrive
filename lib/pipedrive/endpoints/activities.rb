# frozen_string_literal: true

module Pipedrive
  module Endpoints
    module Activities
      def activites(params = {})
        params['limit'] ||= 500
        get_request('/activites', params)
      end
    end
  end
end
