require 'bcrypt'

class Account < ApplicationRecord
	
	belongs_to :user, required: false
	validates :cpf, presence: true
	attr_accessor :name, :email, :cpf, :birth_date, :gender, :city, :state, :country, :status
	
	def self.create(account)
		logger.info "processing the request #{Crypt.decrypt(account.cpf)}"

		return create_or_update(account) if validate(account)

		logger.error "error request is invalid"
		false
	end

	protected

	def self.check_email(email)
		if !email.blank? and email =~ /^[\w\d]+@[\w\d]+(\.[\w\d]+)+$/
			true
		else
			false
		end
	end

	def self.check_cpf(cpf)
		return false if cpf.blank?
	
		invalid = %w{12345678909 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999 00000000000 12345678909}
		val = cpf.scan /[0-9]/
		if val.length == 11
			unless invalid.member?(val.join)
				val = val.collect{|x| x.to_i}
				sum = 10 * val[0] +  9 * val[1] + 8 * val[2] + 7 * val[3] + 6 * val[4] + 5 * val[5] + 4 * val[6] + 3 * val[7] + 2 * val[8]
				sum = sum - ( 11 * ( sum/11 ) )
				result = ( sum == 0 or sum == 1 ) ? 0 : 11 - sum
					
				if result == val[9]
					sum = val[0] * 11 + val[1] * 10 + val[2] * 9 + val[3] * 8 + val[4] * 7 + val[5] * 6 + val[6] * 5 + val[7] * 4 + val[8] * 3 + val[9] * 2
					sum = sum - ( 11 * ( sum/11 ) )
					finale = ( sum == 0 or sum == 1 ) ? 0 : 11 - sum
					
					if finale == val[10]
						logger.debug "valid cpf"
						return true 
					end
				end
			end
		end
		
		logger.debug "invalid cpf"
		false
	end
	
	private 

	def self.validate(account) 
		logger.info "validating and crypt infos for #{Crypt.decrypt(account.cpf)} request"

		if (account.valid? and check_cpf(account.cpf)) or Crypt.already_encrypted?(account.cpf)
			account.cpf = 
				if !Crypt.already_encrypted?(account.cpf)
					Crypt.encrypt(account.cpf)
				else
					account.cpf	
				end
				
			account.email = 
				if !Crypt.already_encrypted?(account.email)
					if (check_email(account.email))
						Crypt.encrypt(account.email)
					end
				else
					account.email	
				end
			
			account.name = 
				if !Crypt.already_encrypted?(account.name)
					if !account.name.blank? 
						Crypt.encrypt(account.name) 
					end
				else
					account.name
				end
			
			account.birth_date =
				if !Crypt.already_encrypted?(account.birth_date)
					if !account.birth_date.blank?
						Crypt.encrypt(account.birth_date)
					end
				else
					account.birth_date
				end
			
			account.status =  
				if (account.name.blank? or check_email(account.email) \
						or account.birth_date.blank? or account.gender.blank? \
						or account.city.blank? or account.state.blank? or account.country.blank?) 
					'pending' 
				else 
					'completed' 
				end

			logger.debug "return #{account} valid"
			true
		else 
			false
		end	
	end
	
	def self.create_or_update(account)
		logger.info "persiting for #{Crypt.decrypt(account.cpf)} request"

		result =
			Account.upsert({
				name: 			account.name,
				email:  		account.email,
				birth_date:	account.birth_date,
				cpf:				account.cpf,
				gender: 		account.gender,
				city:				account.city,
				state:			account.state,
				country:		account.country
			}, unique_by: :cpf)
		
		if result
			logger.info "finish persiting for #{Crypt.decrypt(account.cpf)} record"
			true
		else 
			logger.error "error processing the record #{Crypt.decrypt(account.cpf)}"
			false
		end
	end
end
