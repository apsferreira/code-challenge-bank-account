class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true, length: { minimum: 4 }
  validates :password_digest, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :indicated_referral_code, presence: true, length: { is: 8 }
  validates :referral_code, presence: true, uniqueness: true, length: { is: 8 }
end
