class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :cpf
      t.date :birth_date
      t.string :gender
      t.string :city
      t.string :state
      t.string :country
      t.boolean :pending
      t.uuid :user_id

      t.timestamps
    end
  end
end
