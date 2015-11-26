Xduck::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root :to => "activities#index"

  devise_scope :user do
    get "/users/sign_in" => "devise/sessions#new"
    delete "users/sign_out" => "devise/sessions#destroy"
  end

  ActiveAdmin.routes(self)
  #resources :articles

  devise_for :users
  get "home/index"

  resources :activities, only: [:index, :show, :edit, :destroy, :new, :create, :update] do
    resources :activity_items, only: [:edit, :create, :destroy, :new, :update]
    collection do
      get :new_diff
    end
    controller :reports do
      get :bill
      get :torg12
      get :sf
    end
  end

  get 'activities/ajax_add'
  get 'activities/ajax_edit'
  get 'activities/delete'

  get 'products/ajax_get'

  resources :products
  resources :boms

  resources :bankaccs, only: [:index] do
  end


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
