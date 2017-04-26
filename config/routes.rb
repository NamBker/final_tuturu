
Rails.application.routes.draw do
  root "foods#index"
  get "static_pages/help"
  devise_for :users, controllers: { registrations: :registrations }
  get "foods/newest" => "foods#newest", as: :foods_newest
  get "foods/liked" => "foods#liked", as: :foods_liked
<<<<<<< HEAD
  resources :users do
    member do
      get :following, :followers
    end
  end
=======
  resources :users, only: [:index, :show]
  get "tags/:tag", to: "foods#tag", as: :tag
>>>>>>> c8d5814b9d5e188f78771455911471059bb5b835
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
<<<<<<< HEAD


  resources :relationships, only: [:create, :destroy]
=======
  get "search", to: "foods#index", as: :search
>>>>>>> c8d5814b9d5e188f78771455911471059bb5b835
end
