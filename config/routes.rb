Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :posts
      get '/my_posts', to: 'posts#get_current_user_posts'
      put '/posts/:id/like', to: 'posts#like', as: 'like'
      put '/posts/:id/unlike', to: 'posts#un_like', as: 'un_like'
    end
  end
  devise_for :users,
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              }
  get '/member-data', to: 'members#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
