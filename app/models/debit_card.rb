class DebitCard < ApplicationRecord
  broadcasts_refreshes # update and destroy take care of this
  after_create :broadcast_create

  validates :number, :balance, presence: true
  def reload_balance(amount)
    self.balance += amount
    save
  end

  def deduct_balance(amount)
    self.balance -= amount
    save
  end

  private

  def broadcast_create
    broadcast_prepend_to self, target: "debit_cards", partial: "debit_cards/debit_card", locals: { movie: self }
  end
end
