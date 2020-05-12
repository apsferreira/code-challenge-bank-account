class Account < ApplicationRecord
  belongs_to :user, required: false
	validates :cpf, presence: true, cpf: true
	attr_accessor :name, :cpf, :email, :birth_date, :status, :gender, :city, :state, :country
	
	private

	before_save do |account|
		# account.name = Crypt.encrypt(account.name)
		# account.cpf = Crypt.encrypt(account.cpf)
		# account.email = Crypt.encrypt(account.email)
		# account.birth_date = Crypt.encrypt(account.birth_date)
		account.status = "completed"
			# if @account.name.blank? || @account.email.blank? \
			# 	|| @account.birth_date.blank? || @account.gender.blank? \
			# 	|| @account.city.blank? || @account.state.blank? || @account.country.blank?
			# 			"pending"
			# 		else
			# 			"completed"
			# 		end
  end
end
