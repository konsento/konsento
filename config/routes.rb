Rails.application.routes.draw do

 root 'main#index'
 resources :groups
 resources :topics
end
