class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :referral_code, :is_admin

  has_one :account
end
