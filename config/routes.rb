Rails.application.routes.draw do
  resources :users do
    collection do
      get :login
      post :auth
      delete :logout
    end
  end
  resources :posts do
    resources :comments
  end
  root 'posts#index'
end
