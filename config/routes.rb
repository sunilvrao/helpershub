Helpershub::Application.routes.draw do
  resources :startups

  root :to=>"welcome#index"
  match '/signin'=>'sessions#new'
  match '/signout'=>'sessions#destroy'
  match '/auth/:service/callback'=>'sessions#create'
  match '/auth/failure'=>'sessions#failure'
end
