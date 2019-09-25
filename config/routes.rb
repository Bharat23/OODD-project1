Rails.application.routes.draw do
  match '/books/actions/search/' => 'books#search', :via => :get
  resources :books
    
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
