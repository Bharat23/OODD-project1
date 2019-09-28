Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }, path_names: {
      sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', registration: 'register'
  }
  resources :libraries
  resources :universities

  resources :homes

  match '/userlist/:type' => 'homes#list_users', :via => :get, as: :user_list

  match '/profile/:id' => 'homes#show', :via => :get, as: :profile 
  match '/profile/:id/edit' => 'homes#edit', :via => :get, as: :profile_edit
  match '/profile/:id/edit' => 'homes#update', :via => :put, as: :profile_update
  match '/books/actions/search/' => 'books#search', :via => :get
  
  match '/libraries/add/book/:book_id' => 'libraries#add_book_library', :via => :get, as: :add_book_library
  match '/libraries/add/book/:book_id' => 'libraries#add_update_book_library', :via => :put, as: :put_add_book_library
  resources :books

  # for creating base users
  # seed doesn't work for user tables
  match '/config/createusers/' => 'application#setup_users', :via => :get

  root to: "homes#index"
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
