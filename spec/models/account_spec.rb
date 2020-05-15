# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'associations' do
    it { should belong_to(:user).optional }
  end

  describe 'Validations' do
    it { should validate_presence_of :cpf }
    # it { should validate_uniqueness_of :cpf }
    # it { should validate_uniqueness_of :name }
    # it { should validate_length_of(:name).is_at_least(4) }
    # it { should validate_uniqueness_of :email }
    # it { should validate_length_of(:email).is_at_least(10) }
    # it { should allow_value('teste@teste.com').for(:email) }
  end

  describe '#Account' do
    let(:account) { Account.new(name: Faker::Name.name, email: Faker::Internet.email, cpf: CpfGenerator.generate, gender: Faker::Gender, birth_date: '20/10/2005', city: Faker::Lorem.sentence, state: Faker::Lorem.sentence, country: Faker::Lorem.sentence) }

    context 'is valid' do
      it 'has a valid Account' do
        expect(account).to be_valid
      end
    end

    context 'is invalid' do
      it 'without cpf' do
        account.cpf = nil
        account.valid?
        expect(account.errors[:cpf]).to include("can't be blank")
      end

      it 'empty cpf' do
        account.cpf = ''
        expect(account.valid?).to eq(false)
      end
    end
  end

  describe ' #CPF' do
    let(:account) { Account.new }

    context 'is valid' do
      it 'with a valid cpf' do
        account.cpf = CpfGenerator.generate
        expect(account.valid?).to eq(true)
      end
    end
  end

  describe ' #Status' do
    let(:account) { Account.new(name: Faker::Name.name, email: Faker::Internet.email, cpf: CpfGenerator.generate, gender: Faker::Gender, birth_date: '20/10/2005', city: Faker::Lorem.sentence, state: Faker::Lorem.sentence, country: Faker::Lorem.sentence) }

    context 'As long as all data has not been properly informed and validated, the account will remain in a pending status' do
      it 'status pending for missing data' do
        account.cpf = CpfGenerator.generate
        account.name = nil

        account.validation_status

        expect(account.status).to eq('pending')
      end

      it 'status completed for all completed data' do
        account.validation_status

        expect(account.status).to eq('completed')
      end
    end
  end

  describe ' #Encript name, email, cpf and birth_date if informed' do
    let(:account) { Account.new }

    context 'Encript valid informations' do
      it 'a valid cpf after encription' do
        account.cpf = '98088065038'

        account.process

        expect(account.cpf).to_not eq('98088065038')
      end

      it 'a name and a valid cpf after encription' do
        account.cpf = CpfGenerator.generate
        account.name = 'name'

        account.process

        expect(account.name).to_not eq('name')
      end

      it 'a email and a valid cpf after encription' do
        account.cpf = CpfGenerator.generate
        account.email = 'teste@teste.com'

        account.process

        expect(account.email).to_not eq('test@test.com')
      end

      it 'a birth_date and a valid cpf after encription' do
        account.cpf = CpfGenerator.generate
        account.birth_date = '10/10/2012'

        account.process

        expect(account.birth_date).to_not eq('10/10/2012')
      end
    end
  end
end
