# frozen_string_literal: true

require 'spec_helper'
require 'generator_spec'
require 'generators/pipedrive/pipedrive_token_generator'
require 'tmpdir'
RSpec.describe Pipedrive::Generators::PipedriveTokenGenerator, type: :generator do
  destination File.expand_path(Dir.tmpdir(), __FILE__)
  arguments %w(PipedriveToken)

  before do
    prepare_destination
    run_generator
  end

  it "creates a model file" do
    assert_file "app/models/pipedrive_token.rb",
    <<~CONTENT
      class PipedriveToken < ApplicationRecord
      end
    CONTENT
  end

  it 'creates a miration file' do
    assert_migration "db/migrate/create_pipedrive_tokens.rb",
    <<~CONTENT
      # frozen_string_literal: true

      class CreatePipedriveTokens < ActiveRecord::Migration[5.2]
        def change
          create_table :pipedrive_tokens do |t|
            t.binary :encrypted_access_token
            t.binary :encrypted_refresh_token
            t.datetime :expires_at
            t.string :company_domain, null: false

            t.timestamps null: false
          end

          add_index :pipedrive_tokens, :company_domain
        end
      end
    CONTENT
  end
end
