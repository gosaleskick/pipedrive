# frozen_string_literal: true

require "pipedrive/version"
require 'typhoeus'
require 'oj'
require 'base64'
require 'rbnacl/libsodium'

require 'pipedrive/endpoints/activities'
require 'pipedrive/endpoints/activity_types'
require 'pipedrive/endpoints/deals'
require 'pipedrive/endpoints/users'
require 'pipedrive/endpoints/webhooks'
require 'pipedrive/result'
require 'pipedrive/encryptor'
require 'pipedrive/configuration'
require 'pipedrive/connection'
require 'pipedrive/oauth/token/base'
require 'pipedrive/oauth/token/fetcher'
require 'pipedrive/oauth/token/refresher'
require 'pipedrive/oauth/client'

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
