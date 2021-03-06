Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts do
    resources :comments
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

  namespace :admin do
    resources :comments do
      member do
        post :hide
        post :public
      end
    end
    resources :posts do
      member do
        post :hide
        post :public
      end
    end
    resources :categories
  end

  namespace :account do
    resources :users
  end

  namespace :account do
    resources :posts
  end

  resources :collects
end
