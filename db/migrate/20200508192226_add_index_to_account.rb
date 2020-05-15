# frozen_string_literal: true

class AddIndexToAccount < ActiveRecord::Migration[6.0]
  def change
    add_index :accounts, :cpf, unique: true
  end
end
