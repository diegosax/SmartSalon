Smartsalon::Application.routes.draw do

  get "client_services/index"

  get "client_services/new"

  get "dashboard/index"

  get "dashboard" => "dashboard#index"

  post "favorites" => "favorites#create"

  delete "favorites/:id" => "favorites#destroy"

  resources :settings

  namespace :landing do
    root :to => "pages#index"
    get "pages/index"
    get "pages/about"
  end

  namespace :admin do    
    root :to => "events#index"
    post "payments/notification" => "payments#notification", :as => "payment_notification"
    get 'dashboard' => "dashboard#index"
    
    resources :services do
      collection do
        get 'get_services'
        get 'search'
      end
      resources :client_services
    end      
    
    resources :events do      
      collection do
        get "easy/new" => "events#easy_new"
        post "easy/new" => "events#easy_create"
        get 'get_events'
        get 'search'
      end
      member do
        post "edit" => "events#update"
      end
    end
    
    resources :professionals do
      collection do
        post "search_zipcode" => "professionals#search_zipcode"
      end
      put "update_password" => "professionals#update_password", :as => "update_password", :on => :member
      resources :working_times
      resources :professional_services
    end
    
    resources :salons do
      post "payments/checkout" => "payments#checkout", :as => "payments_checkout"
      get "payments/:payment_id/invoice" => "payments#invoice", :as => "payments_invoice"
    end
    
    resources :clients do
      post "add/to/salon" => "clients#add_to_salon", :as => "add_to_salon"
      collection do
        get "search"
      end
      resources :client_services      
    end
    
    resources :client_services
  end

  devise_for :clients, :controllers =>
  {
    :registrations => "registrations"
  }

  devise_for :users, :controllers => 
  { 
    :registrations => "registrations" ,
    :sessions => "sessions"
  }

  devise_for :professionals, 
  :controllers => 
  { 
    :registrations => "registrations" ,
    :sessions => "admin/sessions"
  }

  resources :clients do
    resources :events
  end

  resources :salons do
    get 'page/:page', :action => :index, :on => :collection
    post "events/:id/edit" => "events#update"
    post "events/new" => "events#create"
    resources :events
  end

  resources :events

  resources :users

  root :to => "dashboard#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
