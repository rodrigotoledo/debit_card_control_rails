class DebitCard < ApplicationRecord
  validates :number, :balance, presence: true
end
