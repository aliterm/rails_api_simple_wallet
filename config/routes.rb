Rails.application.routes.draw do
  get 'transactions/create'
  get 'transactions/credit'
  get 'transactions/debit'
  get 'transactions/transfer'
  get 'wallets/index'
  get 'wallets/show'
  get 'wallets/balance'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

   # User Session Routes
  post '/sign_in', to: 'sessions#create' # Sign-in endpoint
  delete '/sign_out', to: 'sessions#destroy' # Sign-out endpoint

  # Wallet Routes
  resources :wallets, only: [:index, :show] do
    member do
      get :balance  # Retrieve wallet balance
    end
  end

  # Transaction Routes
  resources :transactions, only: [:create, :index] do
    collection do
      post :credit  # Create a credit transaction
      post :debit   # Create a debit transaction
      post :transfer # Create a transfer transaction
    end
  end

  # Fallback Route for Root (optional)
  root to: 'wallets#index' # Default route

  # Defines the root path route ("/")
  # root "posts#index"
end
