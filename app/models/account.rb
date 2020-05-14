class Account < ApplicationRecord
  belongs_to :user, required: false
	validates :cpf, presence: true, cpf: true
		
	def process
		logger.debug "verify user: #{self.user_id}" 
		encrypt_data
		create_or_update
	end

	def validation_status
		self.status =  
			if self.name.blank? || self.email.blank? \
					|| self.birth_date.blank? || self.gender.blank? \
					|| self.city.blank? || self.state.blank? || self.country.blank?
							"pending"
						else
							"completed"
						end
	end

	private

	def encrypt_data 
		logger.debug "encripting data: #{self.name} #{self.cpf} #{self.email} #{self.birth_date}"
		
		self.name = Crypt.encrypt(self.name) unless Crypt.already_encrypted?(self.name)
		self.email = Crypt.encrypt(self.email) unless Crypt.already_encrypted?(self.email)
		self.cpf = Crypt.encrypt(self.cpf) unless Crypt.already_encrypted?(self.cpf)
		self.birth_date = Crypt.encrypt(self.birth_date) unless Crypt.already_encrypted?(self.birth_date)
	end

	def create_or_update
		Account.upsert({
			name: self.name,
			email: self.email,
			cpf: self.cpf,
			birth_date: self.birth_date,
			gender: self.gender,
			city: self.city,
			state: self.state,
			country: self.country,
			status: self.status,
			user_id: self.user_id
		}, unique_by: :cpf)
	end
end
