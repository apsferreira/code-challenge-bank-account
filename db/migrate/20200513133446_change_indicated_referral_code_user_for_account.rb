class ChangeIndicatedReferralCodeUserForAccount < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :indicated_referral_code
    add_column :accounts, :indicated_referral_code,  :string
  end
end
