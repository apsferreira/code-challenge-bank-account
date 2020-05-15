# frozen_string_literal: true

class InsertingCurrentTimestampInCreatedAtAndUpdatedAtOnAccount < ActiveRecord::Migration[6.0]
  def change
    change_column_default :accounts, :created_at, -> { 'CURRENT_TIMESTAMP' }
    change_column_default :accounts, :updated_at, -> { 'CURRENT_TIMESTAMP' }
  end
end
