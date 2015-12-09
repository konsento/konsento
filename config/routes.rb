Rails.application.routes.draw do

 root 'groups#index'
 
 resources :groups
 resources :topics
end
