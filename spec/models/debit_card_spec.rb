require 'rails_helper'

RSpec.describe DebitCard, type: :model do
  let!(:debit_card) { build(:debit_card, number: Faker::Finance.credit_card(:visa)) }

  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:balance) }

  describe '#reload_balance' do
    it 'adds the specified amount to the balance' do
      debit_card.reload_balance(50.0)
      expect(debit_card.balance).to eq(50.0)
    end
  end

  describe '#deduct_balance' do
    it 'subtracts the specified amount from the balance' do
      debit_card = create(:debit_card, balance: 100.0)
      debit_card.deduct_balance(30.0)
      expect(debit_card.balance).to eq(70.0)
    end
  end
end
