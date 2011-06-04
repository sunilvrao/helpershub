Helpershub::Application.routes.draw do

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

  resources :users, :only=>[:index, :show, :edit, :update]

  resources :requests do
    resources :commitments, :only=>[:create]
    resources :comments, :only=>[:create]
    member do
      get "commit"
    end
  end

  resources :categories, :only=>[] do
    resources :requests, :only=>[:index]
    resources :users, :only=>[:index]
  end

  resources :startups do
    resources :requests, :shallow=>true
    member do
      get 'follow' => "startups#follow"
      get 'unfollow' => "startups#unfollow"
    end
  end

  resources :verticals, :only=>[] do
    resources :startups, :only=>[:index]
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
