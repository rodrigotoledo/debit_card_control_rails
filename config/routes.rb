Rails.application.routes.draw do
  namespace :api do
    resources :debit_cards, only: [:create] do
      patch 'reload', on: :member
      patch 'checkout', on: :member
    end
  end
end
