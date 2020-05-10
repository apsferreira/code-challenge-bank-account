require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }
      it { should validate_length_of(:username).is_at_least(4) }
      it { should validate_presence_of(:password_digest) }
      it { should validate_length_of(:password_digest).is_at_least(6) }
      it { should have_secure_password }
      it { should validate_presence_of(:indicated_referral_code) }
      it { should validate_length_of(:indicated_referral_code).is_equal_to(8) }
      it { should validate_uniqueness_of(:referral_code) }
      it { should validate_presence_of(:referral_code) }
      it { should validate_length_of(:referral_code).is_equal_to(8) }
  end
end
