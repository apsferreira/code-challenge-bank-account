class Account < ApplicationRecord
  belongs_to :user, required: false
	validates :cpf, presence: true, cpf: true
		
	def process
		logger.info "processing account creation #{self.name} #{self.cpf} #{self.email} #{self.birth_date} #{self.gender} #{self.city}"

		encrypt_data
		validation_status
		create_or_update
	end

	private

	def encrypt_data 
		logger.debug "encripting data: #{self.name} #{self.cpf} #{self.email} #{self.birth_date}"
		
		self.name = Crypt.encrypt(self.name) unless Crypt.already_encrypted?(self.name)
		self.email = Crypt.encrypt(self.email) unless Crypt.already_encrypted?(self.email)
		self.cpf = Crypt.encrypt(self.cpf) unless Crypt.already_encrypted?(self.cpf)
		self.birth_date = Crypt.encrypt(self.birth_date) unless Crypt.already_encrypted?(self.birth_date)
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

		logger.debug "validation_status #{self.status}"
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
			status: self.status
		}, unique_by: :cpf)
	end
end
