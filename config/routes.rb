Rails.application.routes.draw do
  resources :tabs

  resources :ticket_states, constraints: { id: /\d+/ }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  post '/authenticate' => 'supports#authenticate'

  resources :roles, constraints: { id: /\d+/ }

  resources :supports, constraints: { id: /\d+/ } do
    resources :roles, constraints: { id: /\d+/ }

    member do
      get 'change_password'
    end
  end

  get 'logout', to: 'supports#logout'

  get 'ticket/:uuid', to: 'tickets#show_by_uuid', constraints: { uuid: /[A-Z]{3}\d{3}[A-Z]{3}\d{3}[A-Z]{3}/ }
  post 'ticket/show_by_uuid', to: 'tickets#show_by_uuid'

  resources :tickets, constraints: { id: /\d+/ } do
    resources :comments, constraints: { id: /\d+/ }
  end

  get '/contact' => 'application#contact'

  # You can have the root of your site routed with "root"
  root 'application#index'

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
