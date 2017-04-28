Rails.application.routes.draw do
  root "foods#index"
  get "static_pages/help"
  devise_for :users, controllers: { registrations: :registrations }
  get "foods/newest" => "foods#newest", as: :foods_newest
  get "foods/liked" => "foods#liked", as: :foods_liked
  get "tags/:tag", to: "foods#tag", as: :tag
  resources :foods do
    get :autocomplete_tag_name, :on => :collection
    member do
      put "like", to: "foods#upvote"
      put "dislike", to: "foods#downvote"
    end
    resources :comments do
      member do
        get "upvote" => "comment#upvote", as: :upvote
        get "downvote" => "comment#downvote", as: :downvote
      end
    end
  end
  get "search", to: "foods#index", as: :search
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  post "/rate" => "rater#create", :as => "rate"
end