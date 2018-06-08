# frozen_string_literal: true

class Create<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= table_name %> do |t|
      t.string :access_token
      t.string :refresh_token
      t.datetime :expires_at

      t.timestamps null: false
    end
  end
end
