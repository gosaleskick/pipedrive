# frozen_string_literal: true

require 'rails/generators/active_record'

module Pipedrive
  module Generators
    class PipedriveTokenGenerator < ActiveRecord::Generators::Base
      source_root ::File.expand_path('../templates', __FILE__)
      desc "Generates migration and model to store pipedrive tokens."

      def create_migration_file
        migration_template "migration.rb", "db/migrate/create_#{table_name}.rb", migration_version: migration_version
      end

      def generate_model
        invoke "active_record:model", [name], migration: false
      end

      private

      def migration_version
        if ActiveRecord.version >= Gem::Version.new("5.0")
          "[#{ActiveRecord::Migration.current_version}]"
        end
      end
    end
  end
end
