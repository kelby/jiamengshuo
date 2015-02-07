Rails.application.routes.draw do
  resources :direct_messages, only: [:index, :create, :update, :destroy]

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'activities/index'

  resources :subjects do
    resources :comments
  end

  resources :catalogs

  resources :posts

  post '/add_section', to: "sections#add", as: :add_section
  delete '/remove_section', to: "sections#remove", as: :remove_section

  resources :sections

  resources :wishes do
    member do
      post :got_it
      delete :spurn_it
      get  :followers_by_user
    end
  end

  post 'topic_and_user/sticking/:id' => 'topic_and_user#sticking', as: :sticking_topic
  post 'topic_and_user/followering/:id' => 'topic_and_user#followering', as: :followering_topic
  post 'topic_and_user/keepering/:id' => 'topic_and_user#keepering', as: :keepering_topic

  resources :topics do
    collection do
       get :search
     end
    resources :comments
  end

  resources :comments do
    resources :replies
  end

  resources :replies, only: [:new, :create, :edit, :update, :destroy]

  get 'page/:name' => "pages#show", as: :page

  devise_for :users
  get 'users/profile' => "users#profile"
  get 'users/pending_apply_students', to: "applies#pending_apply_students"
  resources :users, :only => [:show, :index] do
    member do
      get :edit_avatar
      put :update_avatar

    end

    put :approve_apply, to: "applies#approve_apply"
    put :refuse_apply, to: "applies#refuse_apply"
    post :follow
    delete :stop_following

    resources :applies
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index'

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
