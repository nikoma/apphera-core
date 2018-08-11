Rails.application.routes.draw do

  resources :partners
  resources :voters
  resources :proposals
  resources :categories
  resources :providers
  resources :facebook_user_badges
  get 'concepts/:id/edit' => 'concepts#edit'
  get 'applications' => 'apps#public_index'
  get 'privacy' => 'home#privacy'
  get 'chatdemo' => 'home#testchat'
  get 'public_app' => 'apps#public_app', as: :public_app
  get 'public_quiz_concept/:app_id' => 'apps#public_quiz_concept', as: :public_quiz_concept
  post 'submit_public_quiz_concept/:id' => 'apps#submit_public_quiz_concept', as: :submit_public_quiz_concept
  get 'graduates/:id' => 'graduates#index'
  get 'factsheets' => 'home#factsheets_index'
  get 'factsheets/:id' => 'home#factsheets'
  resources :badges
  resources :facebook_users
  resources :news_items do
    collection do
      put 'update_all'
    end
  end

  resources :knowledge_items do
    collection do
      put 'update_all'
    end
  end
  resources :languages
  # resources :migrations
  resources :organizations, only: [:edit, :update]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :prompts
  #resources :promots
  resources :subscriptions
  resources :results
  resources :lists
  # resources :histories
  resources :answers
  # resources :messaging_users
  resources :concepts do
    member do
      get :quiz
      post :submit_quiz
    end
    collection do
      put 'update_all'
    end
  end
  resources :apps do
    member do
      get :concepts
    end
  end
  resources :country_codes
  # resources :blobs
  resources :scripts
  resources :chat_rooms, only: [:new, :create, :show, :index]
  resources :employees, only: [:index, :show, :destroy]
  resources :questions
  resources :request_calls
  resources :contacts
  # mount ActionCable.server => '/cable'
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: "users/passwords",
    invitations: 'users/invitations'
  }
  devise_scope :user do
    get '/revoke_login/:uid/:provider' => 'users/omniauth_callbacks#revoke_login', as: :revoke_login
  end
  resources :companies, except: %i[new create] do
    collection do
      get :signup, path: 'sign_up'
      post :register
    end
  end
  #root 'home#index'
  root 'home#external'
  get '/home' => 'home#home', as: :home

  post 'file/receive' => 'file#receive'
  get '/dashboard' => 'home#dashboard', as: :dashboard

  namespace :api, defaults: {format: 'json'} do

    namespace :v1 do
      # post 'request' => 'request#thing'
      post 'messages' => 'messages#index'
      post 'eqbotics' => 'eqbotics#index'
      post 'gogreenbot' => 'gogreenbot#index'
      post 'hawkmatrix' => 'hawkmatrix#index'
      post 'apphera' => 'apphera#index'
      post 'tarot' => 'tarot#index'
      post 'mudra' => 'mudra#index'
      post 'ascension' => 'ascension#index'
      post 'herbaldoc' => 'herbal_doc#index'



      # post 'filter/classify' => 'filter#classify'
      # post 'filter/untrain' => 'filter#untrain'
      post '/signup' => 'registrations#create'
      post '/signin' => 'sessions#create'
      delete '/logout' => 'sessions#destroy'

      # Resources
      resources :concepts, except: %i[new edit] do
        member do
          post :submit_answer
        end
      end
      resources :apps, only: %i[index]
    end
  end
end
