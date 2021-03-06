Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  root to: "tweets#index"  
  resources :tweets, except: :index do
    resources :comments, only: %i[create destroy]
    collection do
      get 'search'
    end
    resource :likes, only: %i[create destroy]
  end
  resources :users, only: :show 
end
