# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :referral_code

  has_one :account
end
