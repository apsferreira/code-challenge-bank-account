# frozen_string_literal: true

require 'faker'

5.times do
  user = User.new
  user.username = Faker::Name.name
  user.password_digest = Faker::Alphanumeric.alphanumeric(number: 6)
  user.referral_code = Faker::Alphanumeric.alphanumeric(number: 8)

  user.save!

  account = Account.new
  account.name = Faker::Name.name
  account.email = Faker::Internet.email
  account.birth_date = '20/10/2010'
  account.cpf = CpfGenerator.generate
  account.gender = Faker::Gender
  account.city = Faker::Lorem.sentence
  account.state = Faker::Lorem.sentence
  account.country = Faker::Lorem.sentence
  account.indicated_referral_code = user.referral_code
  account.user_id = user.id

  account.process
end
