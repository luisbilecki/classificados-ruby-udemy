Rails.application.routes.draw do
  get 'backoffice', to: 'backoffice/dashboard#index'

  namespace :backoffice do
    #cria rotas
    resources :categories, except: [:show, :destroy]
    resources :admins, except: [:show]
    resources :send_mail, only: [:edit, :create]
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :site do
    get 'home', to: 'home#index'

    namespace :profile do
      resources :dashboard, only: [ :index ]
      resources :ads, only: [ :index ]
    end
  end

  devise_for :admins, :skip => [:registrations]
  devise_for :members

  #Página inicial
  root 'site/home#index'

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
