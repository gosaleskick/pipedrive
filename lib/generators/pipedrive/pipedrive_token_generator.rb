# frozen_string_literal: true

require 'rails/generators/active_record'

module Pipedrive
  module Generators
    class PipedriveTokenGenerator < ActiveRecord::Generators::Base
      source_root ::File.expand_path('../templates', __FILE__)
      desc "Generates migration to store pipedrive tokens."

      def create_migration_file
        migration_template "migration.rb", "db/migrate/create_#{table_name}.rb", migration_version: migration_version
      end

      def generate_model
        invoke "active_record:model", [name], migration: false
      end

      def self.next_migration_number(path)
        next_migration_number = current_migration_number(path) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
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
