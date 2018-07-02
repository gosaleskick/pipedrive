# frozen_string_literal: true

module Pipedrive
  class Encryptor
    class << self
      def encrypt(token)
        encryption_box.encrypt(token)
      end

      def decrypt(token)
        encryption_box.decrypt(token.b)
      end

      private

      def encryption_box
        RbNaCl::SimpleBox.from_secret_key(Pipedrive.configuration.secret_encryption_key.b)
      end
    end
  end
end
