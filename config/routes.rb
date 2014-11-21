CoElv2::Application.routes.draw do

  # needs to come before resources :users
  devise_for  :users, :controllers => { 
    :sessions           => "custom_devise/sessions", 
    :registrations      => "custom_devise/registrations",
    :confirmations      => "custom_devise/confirmations",
    :passwords          => "custom_devise/passwords",
    :unlocks            => "custom_devise/unlocks"
  }

  namespace :admin do
    resources :companies
    resources :client_agreements, only: [:new, :create, :index]
    resources :guides
    resources :locations
    resources :activities
    resources :trips
    resources :registration_agreements, only: [:new, :create, :index]
    resources :dashboard, only: [:index]
  end
  
  resources :trips do 
    resources :trip_dates,  :controller => 'trips/trip_dates'
    resources :images,      :controller => 'trips/trip_images'
    resources :trip_costs,  :controller => 'trips/trip_costs'
    resources :order_items, :controller => 'trips/order_items', only: [:new, :create, :destroy]
    resources :requests,    :controller => 'trips/requests',    only: [:new, :create]
  end

  resources :cart,        only: [:show]
  resources :orders,      only: [:new, :create]
  resources :users
  

  get '/',                                  to: 'static_pages#home'
  get 'guides_application',                 to: 'static_pages#guides_apply'
  get 'faqs',                               to: 'static_pages#faqs'
  get 'about',                              to: 'static_pages#about'
  get 'contact',                            to: 'static_pages#contact'
  get 'order_confirmation',                 to: 'orders#confirmation'
  get 'checkout',                           to: 'orders#new'
  get 'cart',                               to: 'carts#show'
  get 'users/:slug',                        to: 'users#show', as: :profile

  match '*path' => redirect('/'), via: :get
  root 'static_pages#home',       as: :home

  # ajax to js.erb routes

  post 'trips/:trip_id/order_items/total',  to: 'trips/order_items#ajax_calc_total'
  post 'trips/:trip_id/order_items/dates',  to: 'trips/order_items#ajax_dates'


  # # NOT CURRENTLY IN USE ##
  # put   'order_items/:id/confirm_guide',  to: 'order_item_updates#confirm_guide',   as: :confirm_guide
  # get   'confirm_add_participants',       to: 'order_item_updates#confirm_add_participants'
  # get   'confirm_cancel_trip',            to: 'order_item_updates#confirm_cancel_trip'
  # get   'confirm_cancel_participants',    to: 'order_item_updates#confirm_cancel_participants'
  # post  'add_participants',               to: 'order_item_updates#add_participants'
  # post  'cancel_participants',            to: 'order_item_updates#cancel_participants'
  # get   'change_confirmation',            to: 'order_item_updates#change_confirmation'
  # get   'edit_redirect',                  to: 'order_item_updates#edit_redirect', as: :edit_redirect
  #   get 'order_update_confirmation',        to: 'orders#update_confirmation'
  # resources :company_guides 
  # resources :company_guides  




  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
