class DebitCard < ApplicationRecord
  validates :number, :balance, presence: true
  def reload_balance(amount)
    self.balance += amount
    save
  end

  def deduct_balance(amount)
    self.balance -= amount
    save
  end
end
