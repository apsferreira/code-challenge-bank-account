require "rails_helper"

RSpec.describe Account, type: :model do
  describe "associations" do
    it { should belong_to(:user).optional }
  end

  describe "Validations" do
    it { should validate_presence_of :cpf }
    # it { should validate_uniqueness_of :cpf }
    # it { should validate_uniqueness_of :name }
    # it { should validate_length_of(:name).is_at_least(4) }
    # it { should validate_uniqueness_of :email }
    # it { should validate_length_of(:email).is_at_least(10) }
    # it { should allow_value('teste@teste.com').for(:email) }
  end

  describe "#Account" do
    context "is valid" do
      it "has a valid Account" do
        account = build(:account)
        expect(account).to be_valid
      end
    end

    context "is invalid" do
      it "without cpf" do
        account = build(:account, cpf: nil)
        account.valid?
        expect(account.errors[:cpf]).to include("can't be blank")
      end
    end
  end

  describe " #CPF" do
    context "is valid" do
      it "with a valid cpf" do
        expect(Account.check_cpf("80273497022")).to eq(true)
      end
    end

    context "is invalid" do
      it "without cpf" do
        expect(Account.check_cpf("")).to eq(false)
      end

      it "with a invalid cpf" do
        expect(Account.check_cpf("123456")).to eq(false)
      end

      it "with a invalid cpf" do
        expect(Account.check_cpf("12345678901")).to eq(false)
      end

      it "with a invalid cpf" do
        expect(Account.check_cpf("11111111111")).to eq(false)
      end
    end
  end

  describe "Exceptional flow: some data is invalid" do
    context "The system does not create or update an account" do
      it "without cpf" do
        account = build(:account, cpf: nil)
        expect(Account.create(account)).to eq(false)
      end

      it "cpf is invalid" do
        account = build(:account, cpf: "1111111111")
        expect(Account.create(account)).to eq(false)
      end

      it "cpf is empty" do
        account = build(:account, cpf: "")
        expect(Account.create(account)).to eq(false)
      end
    end
  end

  describe " #Status" do
    context "As long as all data has not been properly informed and validated, the account will remain in a pending status" do
      it "status pending for missing data" do
        account = build(:account, name: nil, cpf: "80273497022")

        Account.create(account)

        expect(account.status).to eq("pending")
      end

      it "status completed for all completed data" do
        account = build(:account, cpf: "80273497022")

        Account.create(account)

        expect(account.status).to eq("completed")
      end
    end
  end

  describe " #Encript name, email, cpf and birth_date if informed" do
    context "Encript valid informations" do
      it "a valid cpf after encription" do
        account = build(:account, cpf: "98088065038")

        Account.create(account)

        expect(account.cpf).to_not eq("98088065038")
      end

      it "a name and a valid cpf after encription" do
        account = build(:account, name: "ok", cpf: "98088065038")

        Account.create(account)

        expect(account.name).to_not eq("ok")
      end

      it "a email and a valid cpf after encription" do
        account = build(:account, email: "teste@teste.com", cpf: "98088065038")

        Account.create(account)

        expect(account.email).to_not eq("test@test.com")
      end

      it "a birth_date and a valid cpf after encription" do
        account = build(:account, birth_date: "10/10/2012", cpf: "98088065038")

        Account.create(account)

        expect(account.birth_date).to_not eq("10/10/2012")
      end
    end
  end
end
