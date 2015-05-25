Rails.application.routes.draw do
  get 'contact/new'
  post 'contact/create'

  resources :direct_messages, only: [:index, :create, :update, :destroy]

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'activities/index'

  resources :subjects do
    resources :comments
  end

  resources :catalogs, only: [:index, :show]

  resources :posts

  post '/add_section', to: "sections#add", as: :add_section
  delete '/remove_section', to: "sections#remove", as: :remove_section

  resources :sections

  resources :wishes, only: [:show, :new, :create, :index] do
    member do
      post :got_it
      delete :spurn_it
      get  :followers_by_user
      get  :checkin_by_users
      post :checkin_it
      delete :checkout_it
    end
  end

  post "topics/preview" => "topics#preview"
  get "topics/qi_ta/new" => "topics#new", category: 0
  get "topics/pi_fa/new" => "topics#new", category: 1
  get "topics/ding_zhuo/new" => "topics#new", category: 2
  get "topics/hai_tao/new" => "topics#new", category: 3

  get "topics/qi_ta" => "topics#index", category: 0
  get "topics/pi_fa" => "topics#index", category: 1
  get "topics/ding_zhuo" => "topics#index", category: 2
  get "topics/hai_tao" => "topics#index", category: 3

  resources :topics do
    member do
      post :mark, to: 'topic_and_user#mark'
      delete :unmark, to: 'topic_and_user#unmark'
      post :keep, to: 'topic_and_user#keep'
      delete :unkeep, to: 'topic_and_user#unkeep'

      put 'change_status/:status', to: 'topics#change_status', as: :change_status
    end
    get :manage_snippets, to: "snippets#manage_snippets"

    collection do
       get :search
     end
    resources :comments
    resources :snippets
  end

  resources :comments do
    resources :replies

    member do
      post :like_it, to: 'liker_comments#like_it'
      delete :unlike_it, to: 'liker_comments#unlike_it'
    end
  end

  resources :replies, only: [:new, :create, :edit, :update, :destroy]

  get 'page/:name' => "pages#show", as: :page

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'users/profile' => "users#profile"
  get 'users/pending_apply_students', to: "applies#pending_apply_students"
  resources :users, :only => [:show, :index] do
    member do
      get :edit_avatar
      put :update_avatar
      put :update_basic
      put :update_settings
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
