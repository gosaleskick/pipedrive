# frozen_string_literal: true

module Pipedrive
  module Endpoints
    module ActivityTypes
      def activity_types
        Pipedrive::Result.new(data: get_request('/activityTypes'))
      end
    end
  end
end
