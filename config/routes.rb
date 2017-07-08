Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts do
    collection do
      get :search
    end
    member do
      post :collect
      post :uncollect
      post :like
      post :unlike
      post :hate
    end
  end
end
