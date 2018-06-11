# frozen_string_literal: true

require "pipedrive/version"
require 'typhoeus'
require 'oj'
require 'base64'

require 'pipedrive/endpoints/users'
require 'pipedrive/endpoints/activity_types'
require 'pipedrive/endpoints/activities'
require 'pipedrive/token/refresher'
require 'pipedrive/result'
require 'pipedrive/configuration'
require 'pipedrive/client'

module Pipedrive
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end
end
