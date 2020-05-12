FactoryBot.define do
  factory :user do
    username { Faker::Alphanumeric.alphanumeric(number: 6) }
    password_digest { Faker::Alphanumeric.alphanumeric(number: 6) }
    indicated_referral_code { Faker::Alphanumeric.alphanumeric(number: 8) }
    referral_code { Faker::Alphanumeric.alphanumeric(number: 8) }
    is_admin { Faker::Boolean }
  end
end
