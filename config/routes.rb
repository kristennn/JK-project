Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts do
    resources :comments
    member do
      post :collect
      post :uncollect
    end
  end
end
