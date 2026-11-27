Rails.application.routes.draw do
  root "gamejams#index"

  resource :user, path: "/profile/:nickname", param: :nickname, only: [:show, :edit, :update, :destroy] do
    get "authored_gamejams", to: redirect(path: "?author=%{nickname}")
    get "/jam_commands", to: "jam_commands#index"
    get "/jam_submissions", to: "jam_submissions#index"
  end
  get "/users/:nickname", to: redirect("/profile/%{nickname}")
  resource :session
  resources :passwords, param: :token
  resource :sign_up
  namespace :settings do
    resource :password, only: [ :show, :update ]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :gamejams do
    resources :commands, controller: "jam_commands"
    resources :submissions, controller: "jam_submissions", except: [:new, :create]
  end
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
