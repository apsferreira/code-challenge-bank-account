class Accounts::IndexSerializer < AccountSerializer
    attributes :name, :email, :status, :id

    belongs_to :user
end