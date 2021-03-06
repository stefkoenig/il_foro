Rails.application.routes.draw do
 root "posts#index"

  #Sessions routes
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  resources :posts, except: [:edit, :update, :destroy] do
      resources :comments, only: [:edit, :create, :update]
      delete 'posts/:post_id/comments/:id' => 'comments#destroy', as: :delete_comment
      member do
          put 'like' => "posts#upvote"
          put 'dislike' => "posts#downvote"
      end
  end

  delete 'posts/:id' => 'posts#destroy', as: :delete_post
  get 'posts/:id/edit' => 'posts#edit', as: :edit_post
  patch 'posts/:id' => 'posts#update'

  resources :users
  get 'login', to: 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]



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
