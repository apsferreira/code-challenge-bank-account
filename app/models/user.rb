class User < ApplicationRecord
  has_secure_password
  has_one :account
  validates :username, presence: true, uniqueness: true, length: {minimum: 4}
  validates :password_digest, presence: true, length: {minimum: 6}, if: -> { new_record? || !password.nil? }
  validates :referral_code, uniqueness: true, length: {is: 8}

  attr_accessor  :username, :password_digest, :referral_code
end
