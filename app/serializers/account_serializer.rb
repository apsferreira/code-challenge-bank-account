class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :cpf, :birth_date, :gender, :city, :state, :country, :status

  belongs_to :user
end
