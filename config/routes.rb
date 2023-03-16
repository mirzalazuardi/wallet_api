Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post 'users/deposit'
      post 'users/withdraw'
      post 'teams/deposit'
      post 'teams/withdraw'
      post 'session', to: 'session#create'
    end
  end
end
