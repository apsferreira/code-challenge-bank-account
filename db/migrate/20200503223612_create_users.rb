class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :username
      t.string :password_digest
      t.string :indicated_referral_code
      t.string :referral_code
      t.boolean :is_admin

      t.timestamps
    end
  end
end
