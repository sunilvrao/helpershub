Helpershub::Application.routes.draw do

  devise_for :admins do 
    get "/admin"=>"admin#index", :as=>:admin_root
    namespace :admin do
      resources :users, :only=>[] do
        member do
          post "approve"=>"admin#approve"
        end
      end
    end
  end

  resources :profiles
  resources :users, :only=>[:edit, :update]

  resources :requests do
    resources :commitments, :only=>[:create]
    member do
      get "commit"
    end
  end

  resources :categories, :only=>[] do
    resources :requests, :only=>[:index]
  end

  resources :startups do
    resources :requests, :shallow=>true
  end

  root :to=>"welcome#index"
  match "not-activated"=>"welcome#not_activated", :as=>:not_activated
  get "profile"=>"welcome#profile", :as=>:profile
  get "dashboard"=>"welcome#dashboard"
  match '/signin'=>'sessions#new'
  match '/signout'=>'sessions#destroy'
  match '/auth/:service/callback'=>'sessions#create'
  match '/auth/failure'=>'sessions#failure'
end
