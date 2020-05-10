class Crypt
	def self.encrypt(value)
		Base64.encode64(value)
	end

	def self.decrypt(value)
		Base64.decode64(value)
	end

	def self.already_encrypted?(value)
		value.is_a?(String) && Base64.encode64(Base64.decode64(value)) == value
	end
end