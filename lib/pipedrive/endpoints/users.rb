# frozen_string_literal: true

module Pipedrive
  module Endpoints
    module Users
      def users
        Pipedrive::Result.new(data: get('/users'))
      end

      def users_me
        Pipedrive::Result.new(data: get('/users/me'))
      end
    end
  end
end
