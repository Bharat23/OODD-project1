Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }, path_names: {
      sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', registration: 'register'
  }
  resources :libraries
  resources :universities
  match '/books/actions/search/' => 'books#search', :via => :get
  resources :books
  root to: "books#index"
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
