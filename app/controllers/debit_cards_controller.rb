# app/controllers/debit_cards_controller.rb

class DebitCardsController < ApplicationController

  # GET /debit_cards
  def index
    @debit_cards = DebitCard.order(updated_at: :desc)
  end
end
