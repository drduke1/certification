Certification::Application.routes.draw do 
  resources :sections

  resources :tests

	root "sessions#new"
	
  get "home", to: "static_pages#home"
  get "static_pages/help"
  get "overview", to: "static_pages#overview"
  
  get "/mc_question", to: "questions#new_mc", as: "new_mc_question"
  get "/tf_question", to: "questions#new_tf", as: "new_tf_question"
  post "/mc_question", to: "questions#create"
  post "/tf_question", to: "questions#create"
  post "/tests/count_questions", to: "tests#count_questions"
  
  get "/newgen", to: "tests#newgen", as: "newgen_test"
  post "/newgen", to: "tests#creategen"
  
  get "/print/:id", to: "tests#print", as: 'print'
  get "/new_form", to: "scores#new_form"
  post "/new_form", to: "scores#new"
  
  resources :answers

  resources :products

  resources :questions
  
  resources :tests

  resources :users
  
  resources :prints
  
  resources :scores
  
  resources :sessions, only: [:new, :create, :destroy]
  
  match '/signin', 	to: "sessions#new",				via: "get"
  match '/signout', to: "sessions#destroy",		via: "delete"
  
  match '/reset',            to: 'sessions#reset',                   via: "get"
  match '/reset_password',   to: 'sessions#reset_password',          via: "get"
  match '/reset',            to: 'sessions#reset',                   via: "post"
  match '/reset_password',   to: 'sessions#reset_password',          via: "post"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
