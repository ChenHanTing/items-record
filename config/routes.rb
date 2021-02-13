Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :items do
      get :download, on: :collection
    end
  end
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
