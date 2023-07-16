Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  root to: "home#top"
  devise_for :users
  get 'home/about' => 'home#about', as: 'about'
  resources :books, only: [:index, :create, :show, :destroy]
  resources :users, only: [:index, :show, :edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
