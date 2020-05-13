class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :status

  belongs_to :user
end
