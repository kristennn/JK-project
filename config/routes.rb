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

  namespace :admin do
    resources :comments do
      member do
        post :hide
        post :public
      end
    end
  end
end
