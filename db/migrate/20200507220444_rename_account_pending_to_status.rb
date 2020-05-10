class RenameAccountPendingToStatus < ActiveRecord::Migration[6.0]
  def change
    rename_column :accounts, :pending, :status
  end
end
