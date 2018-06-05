# frozen_string_literal: true

module Pipedrive
  module Endpoints
    module Users
      def users
        get_request('/users')
      end
    end
  end
end
