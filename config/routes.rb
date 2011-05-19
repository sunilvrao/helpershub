Helpershub::Application.routes.draw do

  resources :job_applications

  resources :jobs do
    resources :job_applications
    resources :questions, :only=>[:create]
    member do
      get "apply"
    end
  end

  resources :categories, :only=>[] do
    resources :jobs, :only=>[:index]
  end

  resources :startups do
    resources :jobs, :shallow=>true
  end

  root :to=>"jobs#index"
  match '/signin'=>'sessions#new'
  match '/signout'=>'sessions#destroy'
  match '/auth/:service/callback'=>'sessions#create'
  match '/auth/failure'=>'sessions#failure'
end
