Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
  root to: 'homes#top'
  get 'home/about', to: 'homes#about'
  get "search" => "searches#search"

  resources :users , :only => [:index, :show, :edit, :update,] do
    member do
      get :follows, :followers
    end
      get "search_form", to: "users#search_form"
      resource :relationships, only: [:create, :destroy]
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :groups, only:  [:new, :index, :show, :create, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
