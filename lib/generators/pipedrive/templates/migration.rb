class CreatePipedriveTokens < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :pipedrive_tokens do |t|
      t.string :access_token
      t.string :refresh_token
      t.datetime :expires_at
    end
  end
end
