Rails.application.routes.draw do
  namespace :api do
    resources :debit_cards, only: [:create] do
      post 'reload', on: :member
      post 'checkout', on: :member
    end
  end
end
