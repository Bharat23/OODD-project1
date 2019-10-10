Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
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
  match '/profile/:id/delete' => 'homes#destroy', :via => :delete, as: :profile_delete
  match '/books/actions/search/' => 'books#search', :via => :get
  
  match '/libraries/add/book/:book_id' => 'libraries#add_book_library', :via => :get, as: :add_book_library
  match '/libraries/add/book/:book_id' => 'libraries#add_update_book_library', :via => :put, as: :put_add_book_library
  resources :books

  # approvals
  match '/users/signup-request' => 'approvals#list_user_signup_approval', :via => :get, as: :list_user_signup_approval
  match '/users/signup-request/:id/:type' => 'approvals#approve_reject_signup', :via => :get, as: :approve_reject_signup

  match '/users/create' => 'homes#new_user_by_admin', :via => :get, as: :new_user_by_admin
  match '/users/create' => 'homes#create_user_by_admin', :via => :post, as: :create_user_by_admin

  # for creating base users
  # seed doesn't work for user tables
  match '/config/createusers/' => 'application#setup_users', :via => :get

  # Book return and issue
  match '/books/book_return/:id' => 'books#book_return', :via => :put, as: :book_return
  match '/books/checkout/:id' => 'books#checkout', :via => :put, as: :checkout
  match '/books/book_issued_list/:id' => 'books#book_issued_list', :via => :put , as: :book_issued_list
  match '/books/book_issued_list/:id' => 'books#book_issued_list', :via => :get , as: :book_issued_list_get

  match '/books/borrow-history/:book_id' => 'books#borrow_history', :via => :get, as: :borrow_history

  # Waitlist
  match '/books/waitlist/:id' => 'books#waitlist', :via =>:get, as: :waitlist

  # Bookmarks
  match '/bookmarks/view_bookmark' => 'bookmarks#view_bookmark', :via => :get , as: :view_bookmark
  match '/bookmarks/destroy/:book_id' => 'bookmarks#destroy' ,:via => :delete , as: :delete_bookmark
  match '/books/bookmark/:id' => 'books#bookmark',:via => :post, as: :bookmark
  root to: "homes#index"

  # approve_holds
  match '/approve_holds/showholdrequests/:libraries_id' => 'approve_holds#show_hold_requests', :via => :get, as: :hold_request
  match '/approve_holds/approve_reject_request/:record_id/:approval_type' => 'approve_holds#approve_reject_request', :via => :get, as: :approve_reject_request

  #holds
  match '/hold_requests/:user_id' => 'hold_requests#checkout_hold_list', :via => :get, as: :checkout_hold_list
  match '/hold_requests/delete_hold_request/:stud_id/:b_id' => 'hold_requests#delete_hold_request', :via => :get, as: :delete_hold_request
  # end
  #
  match '/books/checked_out_books/:user_id' => 'books#checked_out_books', :via => :get, as: :checked_out_books
  #

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
