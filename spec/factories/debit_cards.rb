# spec/factories/debit_cards.rb

FactoryBot.define do
  factory :debit_card do
    number { Faker::Finance.credit_card(:visa) }
    balance { 0 }
  end
end
