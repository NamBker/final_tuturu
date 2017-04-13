	Rails.application.routes.draw do
  resources :foods
  root 'static_pages#home'

  get 'static_pages/help'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
