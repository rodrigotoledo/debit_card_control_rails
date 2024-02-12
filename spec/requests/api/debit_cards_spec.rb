# spec/requests/api/debit_cards_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::DebitCardsController, type: :request do
  describe 'POST /api/debit_cards' do
    it 'creates a new debit card' do
      debit_card_params = { debit_card: { number: '1234567890123456', balance: 100.0 } }

      post '/api/debit_cards', params: debit_card_params

      expect(response).to have_http_status(:created)
    end

    it 'error when credit card is invalid' do
      debit_card_params = { debit_card: { number: '', balance: '' } }

      post '/api/debit_cards', params: debit_card_params

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH /api/debit_cards/:id/reload' do
    let(:debit_card) { create(:debit_card, balance: 100.0) }

    it 'reloads the balance of the debit card' do
      reload_params = { amount: 50.0 }

      patch "/api/debit_cards/#{debit_card.id}/reload", params: reload_params

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include({ "balance" => 150 })
    end

    it 'returns an error if amount is not greater than zero' do
      reload_params = { amount: 0 }

      patch "/api/debit_cards/#{debit_card.id}/reload", params: reload_params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include({ error: 'Amount must be greater than zero' }.to_json)
    end
  end

  describe 'PATCH /api/debit_cards/:id/checkout' do
    let(:debit_card) { create(:debit_card, balance: 100.0) }

    it 'deducts the specified amount from the debit card balance' do
      checkout_params = { amount: 50.0 }

      patch "/api/debit_cards/#{debit_card.id}/checkout", params: checkout_params

      expect(response).to have_http_status(:ok)
      expect(response.body).to include({ message: 'Checkout successful' }.to_json)
    end

    it 'returns an error if there are insufficient funds' do
      checkout_params = { amount: 150.0 }

      patch "/api/debit_cards/#{debit_card.id}/checkout", params: checkout_params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include({ error: 'Insufficient funds' }.to_json)
    end
  end
end
