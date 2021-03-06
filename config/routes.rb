Rails.application.routes.draw do
  resources :requests do
    collection do
      get :show_list
    end
  end
  resources :announcements
  resources :users
  resources :syllabuses
  resources :recruitments
  resources :charges
  resources :staffs
  resources :courses
  resources :subjects
  get 'top/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'top#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  resources :charges do
    collection { post :import }
  end

  resources :syllabuses do
    collection { post :import }
  end

  controller :sessions do
    get 'signin' => :new
    post 'signin' => :create
    delete 'signout' => :destroy
  end
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

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

  get '*unmatched_route', to: 'application#raise_not_found'
end
