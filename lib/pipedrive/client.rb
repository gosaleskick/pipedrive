# frozen_string_literal: true

module Pipedrive
  class Client
    include Pipedrive::Endpoints::Users
    include Pipedrive::Endpoints::ActivityTypes
    include Pipedrive::Endpoints::Activities

    BASE_API_URL = 'https://saleskick.pipedrive.com/v1'
    def initialize(api_token:)
      @api_token = api_token
    end

    private

    attr_reader :api_token

    def get_request(endpoint_path, params = {})
      response = Typhoeus::Request.get(
        "#{BASE_API_URL}#{endpoint_path}",
        params: { api_token: api_token }.merge(params),
        headers: { 'Content-Type': 'application/json' }
      )

      Oj.load(response.response_body)
    end
  end
end
