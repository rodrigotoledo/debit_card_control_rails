class Api::DebitCardsController < ActionController::API
  before_action :set_debit_card, only: [:reload, :checkout]

  def create
    @debit_card = DebitCard.new(debit_card_params)

    if @debit_card.save
      render json: @debit_card, status: :created
    else
      render json: @debit_card.errors, status: :unprocessable_entity
    end
  end

  def reload
    amount = params[:amount].to_f

    if amount <= 0
      render json: { error: 'Amount must be greater than zero' }, status: :unprocessable_entity
    else
      @debit_card.reload_balance(amount)
      render json: @debit_card
    end
  end

  def checkout
    amount = params[:amount].to_f

    if @debit_card.balance < amount
      render json: { error: 'Insufficient funds' }, status: :unprocessable_entity
    else
      @debit_card.deduct_balance(amount)
      render json: { message: 'Checkout successful' }
    end
  end

  private

  def set_debit_card
    @debit_card = DebitCard.find_by(number: params[:id])
  end

  def debit_card_params
    params.require(:debit_card).permit(:number, :balance)
  end
end
