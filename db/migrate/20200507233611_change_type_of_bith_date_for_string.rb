# frozen_string_literal: true

class ChangeTypeOfBithDateForString < ActiveRecord::Migration[6.0]
  def change
    change_column :accounts, :birth_date, :string
  end
end
