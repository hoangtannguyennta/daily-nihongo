Rails.application.routes.draw do
  get "dashboard/index"
  root "dashboard#index"

  resources :kanas do
    collection do
      get :quiz
    end
  end
  resources :vocabularies, only: [ :index, :show, :new, :create, :edit, :update, :destroy ] do
    collection do
      get :random
      get :quiz
      delete :clear_quiz_session
    end
  end
  resources :kanjis, only: [ :index, :show, :new, :create, :edit, :update, :destroy ] do
    collection do
      get :quiz
      get :clear_quiz_session
    end
  end
  resources :posts
  resources :sessions, only: [ :new, :create, :destroy ]
  resources :users, only: [ :new, :create, :index, :edit, :update, :destroy ]
  resources :user_vocabularies do
    collection do
      get :progress
      get :total_score
      post :update_status
    end
  end
  resources :dashboard, only: [ :index ]
  resources :test_attempts, only: [ :index ] do
      collection do
        get :start_test
        post :submit_test
      end
  end
  resources :otp_verifications, only: [ :new, :create ] do
    collection do
      post :resend
    end
  end
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  namespace :admin do
    resource :dashboards, controller: "dashboards", only: [ :show ]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
