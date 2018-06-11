# frozen_string_literal: true

class Create<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= table_name %> do |t|
      t.string :access_token
      t.string :refresh_token
      t.datetime :expires_at
      t.string :company_domain, null: false

      t.timestamps null: false
    end

    add_index :<%= table_name %>, :company_domain
  end
end
