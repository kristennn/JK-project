Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts do
    member do
      post :collect
      post :uncollect
    end
  end
end
