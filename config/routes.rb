Rails.application.routes.draw do
  root 'foods#index'

  get 'static_pages/help'
  devise_for :users, controllers: { :registrations => :registrations }
  resources :users, only: :show
  resources :foods do
    member do
      put "like", to: "foods#upvote"
      put "dislike", to: "foods#downvote"
    end
    resources :comments do
      member do
        get 'upvote' => 'comment#upvote', as: :upvote
        get 'downvote' => 'comment#downvote', as: :downvote
      end
    end
  end
end
