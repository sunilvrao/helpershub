Helpershub::Application.routes.draw do
  resources :jobs

  resources :categories, :only=>[] do
    resources :jobs, :only=>[:index]
  end

  resources :startups do
    resources :jobs, :shallow=>true
  end

  root :to=>"welcome#index"
  match '/signin'=>'sessions#new'
  match '/signout'=>'sessions#destroy'
  match '/auth/:service/callback'=>'sessions#create'
  match '/auth/failure'=>'sessions#failure'
end
