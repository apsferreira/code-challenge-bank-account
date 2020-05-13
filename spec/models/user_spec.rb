require "rails_helper"

RSpec.describe User, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_length_of(:username).is_at_least(4) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password_digest).is_at_least(6) }
    it { should have_secure_password }
    it { should validate_uniqueness_of(:referral_code) }
    it { should validate_length_of(:referral_code).is_equal_to(8) }
  end

  describe "#User" do
    context "is valid" do
      it "has a valid User" do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    context "is invalid" do
      it "without password" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end

      it "without username" do
        user = build(:user, username: nil)
        user.valid?
        expect(user.errors[:username]).to include("can't be blank")
      end

      it "invalid referral_code" do
        user = build(:user, referral_code: "2313")
        expect(user.save).to eq(false)
      end
    end
  end
end
