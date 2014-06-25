Weibo::Application.routes.draw do
  resources :sessions,only:[:new,:create,:destroy]

  match 'signup',to:'users#new',via:'get'
  match 'signin',to:'sessions#new',via:'get'
  match 'signout',to:'sessions#destroy',via:'delete'

  root "static_page#home"
  match "/help",to: 'static_page#help', via:'get'
  match "/about",to: "static_page#about",via:'get'
  match "/contact",to: "static_page#contact",via:'get'

  match '/signup',to:'users#new',via:'get'
  resources :microposts, only:[:create,:destroy]

  resources :users do
    member do
      get :following,:followers
    end
  end

  resources :relationships,only: [:create,:destroy]

  match '/searchs',to:'searchs#index',via:'post'

  match '/at',to:'at#index',via:'get'


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