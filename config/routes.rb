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
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  get "home/index"

  resources :activities, only: [:index, :show, :edit, :destroy, :new, :create, :update] do
    resources :activity_items, only: [:edit, :create, :destroy, :new, :update] do
      collection do
        delete :destroy_checked
      end
    end
    collection do
      get :new_diff
    end
    controller :reports do
      get :bill
      get :torg12
      get :upd
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
end
