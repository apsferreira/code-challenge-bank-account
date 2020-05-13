class Account < ApplicationRecord
  belongs_to :user, required: false
	validates :cpf, presence: true, cpf: true
	attr_accessor :name, :cpf, :email, :birth_date, :status, :gender, :city, :state, :country

	def process
		logger.info "processing account creation"

		encrypt_data
		validation_status
		create_or_update
	end

	private

	def encrypt_data 
		logger.debug "encripting data: #{@name} #{@cpf} #{@email} #{@birth_date}"
		
		@name = Crypt.encrypt(@name) unless Crypt.already_encrypted?(@name)
		@email = Crypt.encrypt(@email) unless Crypt.already_encrypted?(@email)
		@cpf = Crypt.encrypt(@cpf) unless Crypt.already_encrypted?(@cpf)
		@birth_date = Crypt.encrypt(@birth_date) unless Crypt.already_encrypted?(@birth_date)
	end

	def validation_status
		@status =  
			if @name.blank? || @email.blank? \
					|| @birth_date.blank? || @gender.blank? \
					|| @city.blank? || @state.blank? || @country.blank?
							"pending"
						else
							"completed"
						end

		logger.debug "validation_status #{@status}"
	end

	def create_or_update
		Account.upsert({
			name: @name,
			email: @email,
			cpf: @cpf,
			birth_date: @birth_date,
			gender: @gender,
			city: @city,
			state: @state,
			country: @country,
			status: @status
		}, unique_by: :cpf)
	end
end
