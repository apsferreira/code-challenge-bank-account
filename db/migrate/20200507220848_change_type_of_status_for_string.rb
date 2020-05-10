class ChangeTypeOfStatusForString < ActiveRecord::Migration[6.0]
  def change
    change_column :accounts, :status, :string
  end
end
