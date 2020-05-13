class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :referral_code
end
