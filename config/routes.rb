	Rails.application.routes.draw do
  resources :foods
  root 'foods#index'

  get 'static_pages/help'
  devise_for :users, controllers: { :registrations => :registrations }
  resources :users, only: :show
end
