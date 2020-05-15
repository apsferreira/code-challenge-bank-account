# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user, required: false
  validates :cpf, presence: true, cpf: true

  def process
    logger.debug "verify user: #{user_id}"
    encrypt_data
    create_or_update
  end

  def validation_status
    self.status =
      if name.blank? || email.blank? \
            || birth_date.blank? || gender.blank? \
            || city.blank? || state.blank? || country.blank?
        'pending'
      else
        'completed'
              end
  end

  private

  def encrypt_data
    logger.debug "encripting data: #{name} #{cpf} #{email} #{birth_date}"

    self.name = Crypt.encrypt(name) unless Crypt.already_encrypted?(name)
    self.email = Crypt.encrypt(email) unless Crypt.already_encrypted?(email)
    self.cpf = Crypt.encrypt(cpf) unless Crypt.already_encrypted?(cpf)
    unless Crypt.already_encrypted?(birth_date)
      self.birth_date = Crypt.encrypt(birth_date)
end
  end

  def create_or_update
    Account.upsert({
                     name: name,
                     email: email,
                     cpf: cpf,
                     birth_date: birth_date,
                     gender: gender,
                     city: city,
                     state: state,
                     country: country,
                     status: status,
                     user_id: user_id,
                     indicated_referral_code: indicated_referral_code
                   }, unique_by: :cpf)
  end
end
