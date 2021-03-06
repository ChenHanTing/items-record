Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications,
                     :authorized_applications
  end

  devise_for :users

  namespace :admin do
    resources :items do
      get :download, on: :collection
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  # Static pages
  namespace :static_page do
    resources :grids, only: :index do
      collection do
        get :basic_grid_first
        get :basic_grid_second
        get :basic_grid_third
        get :basic_grid_fourth
        get :photo_gallery
        get :animated_grid
      end
    end
  end

  # api
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'login', to: 'tokens#login'
      post 'refresh', to: 'tokens#refresh'
      post 'logout', to: 'tokens#revoke'
    end
  end
end
