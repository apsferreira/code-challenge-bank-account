class EncryptionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if options[:fields].any?
      options[:fields].each do |field|
        record.errors[field] << "#{field} is not crypted" unless Crypt.already_encrypted(record.send(field))
      end
    end
  end
end
