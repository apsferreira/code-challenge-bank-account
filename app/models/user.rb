class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true, length: { minimum: 4 }
  validates :password_digest, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :referral_code, uniqueness: true, length: { is: 8 }
end
