# frozen_string_literal: true

require 'rails/generators/active_record'

module Generators
  module Pipedrive
    class PipedriveTokenGenerator < Rails::Generators::Base
      include Rails::Generators::ResourceHelper

      desc "Generates migration to store pipedrive tokens."
      source_root File.expand_path("../templates", __FILE__)

      def create_migration_file
        migration_template "migration.rb", "db/migrate/add_pipedrive_token.rb"
      end

      private

      def migration_version
        if Rails.version.start_with? '5'
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end
    end
  end
end
