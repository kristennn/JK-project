Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts do
    member do
      post :collect
      post :uncollect
      post :like
      post :unlike
      post :hate
    end
  end
end
