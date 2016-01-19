Rails.application.routes.draw do
  # Root
  root 'groups#index'

  # Auth
  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource :session, controller: 'clearance/sessions', only: [:create]

  resources :users do
   resource :password, controller: 'clearance/passwords', only: [:create, :edit, :update]
  end

  get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  get '/sign_up' => 'users#new', as: 'sign_up'
  delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'

  # Resouces
  resources :groups do
    resources :topics, only: [:new, :create]
  end

  resources :topics, only: [:show]
  resources :proposals, only: [:create]
  resources :subscriptions, only: [:create, :destroy]
  resources :comments, only: [:create]
  resources :invitations, only: [:index, :create] do
    post :send_email, on: :member
    get '/register/:token' => 'invitations#registration_form', on: :collection, as: :registration_form
    post '/register/:token' => 'invitations#register', on: :collection, as: :register
  end

  # Get
  get '/requirement_values', to: 'requirement_values#index', as: 'index_requirement_values'
  get '/requirement_values/:group_id/:user_id/new', to: 'requirement_values#new'

  get '/search', to: 'search#index'

  # Post
  post '/requirement_values/:group_id/:user_id/', to: 'requirement_values#create', as: 'requirement_values'

  # JS
  namespace :js,  defaults: {format: :js} do
    resources :proposals, only: [] do
      member do
        get :children
        post :comments
        post :agree
        post :abstain
        post :disagree
        post :propose
      end
    end
  end
end
