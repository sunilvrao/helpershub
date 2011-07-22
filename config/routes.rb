Helpershub::Application.routes.draw do

  resources :contacts, :only => [:create]

  get "frontpage/index"

  devise_for :admins do 
    get "/admin"=>"admin#index", :as=>:admin_root
    resources :users, :only=>[] do
      member do
        post "approve"=>"admin#approve"
        post "ban"=>"admin#ban"
      end
    end
  end

  resources :pages

  resources :profiles
  resources :professions, :only=>[] do
    resources :profiles, :only=>[:all]
  end

  resources :categories, :only=>[] do
    resources :requests, :only=>[:index] do
      collection do
        get "uncommitted"
        get "popular"
      end
    end
    resources :users, :only=>[:index] do
      collection do
        get "active" => "users#most_active"
      end
    end
  end
  
  resources :users, :only=>[:index, :show, :edit, :update] do
    collection do
      get "active" => "users#most_active"
    end
    member do
      get 'follow' => "users#follow"
      get 'unfollow' => "users#unfollow"
      get 'followers' => "users#followers"
      get 'follows' => "users#follows"
    end
    resources :requests, :only=>[:index]
    resources :startups, :only=>[:index]
  end
  
  resources :requests do
    resources :commitments, :only=>[:create]
    resources :comments, :only=>[:create]
    member do
      get "commit"
    end
    collection do
      get "uncommitted"
      get "popular"
    end
  end

  resources :verticals, :only=>[] do
    resources :startups, :only=>[:index]
  end
  
  resources :startups do
    resources :requests, :shallow=>true
    resource :team
    resources :invitations do
      member do
        get 'accept'=>'invitations#accept'
      end
    end
    member do
      get 'follow' => "startups#follow"
      get 'unfollow' => "startups#unfollow"
    end
  end

  root :to=>"frontpage#index"
  match "not-activated"=>"welcome#not_activated", :as=>:not_activated
  get "profile"=>"welcome#profile", :as=>:profile
  get "dashboard"=>"welcome#dashboard"
  match '/signin'=>'sessions#new'
  match '/signin_as' => 'sessions#sign_in_as'
  match '/signout'=>'sessions#destroy'
  match '/auth/:service/callback'=>'sessions#create'
  match '/auth/failure'=>'sessions#failure'
end
