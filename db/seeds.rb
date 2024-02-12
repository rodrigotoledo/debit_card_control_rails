require 'faker'

DebitCard.create(number: 1234, balance: Faker::Number.decimal(l_digits: 2))
5.times do
  DebitCard.create(number: Faker::Finance.credit_card(:visa), balance: Faker::Number.decimal(l_digits: 2))
end
