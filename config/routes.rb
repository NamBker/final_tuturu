	Rails.application.routes.draw do
  resources :foods
  root 'static_pages#home'

  get 'static_pages/help'
  root 'foods#index'
  devise_for :users
  resources :foods
  resources :users, only: :show
end
