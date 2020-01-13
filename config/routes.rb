Rails.application.routes.draw do
  
  get '/login' => 'user#login'
  post '/login' => 'user#login'
  get '/my_sites' => 'user#sites'
  post '/assign_site' => 'user#assign_site'
  get '/sign_up' => 'user#signup'
  post '/sign_up' => 'user#create'

  get '/sites' => 'location#index'
  get '/emr_sites' => 'location#show'


  get '/update_status' => 'site_status#new'
  get '/site_status' => 'site_status#index'
  get '/emr_assigned_sites' => 'site_status#assigned_sites'
  post '/update_assigned_sites' => 'site_status#create'
  get '/assigned_emr_sites' => 'site_status#assigned_emr_sites'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
