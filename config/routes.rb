Rails.application.routes.draw do
  root 'means#index'
  get :sign_up, to: 'users#new'
  post :sign_up, to: 'users#create'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :reports, only: [:new, :create]

  resources :means do
    resources :mean_comments, only: [:create, :update, :destroy], module: :means
    resource :bookmark, only: [:create, :destroy]
    resource :like, only: [:create, :destroy]
  end

  resources :diaries, only: [:index, :new, :create, :show, :destroy] do
    resource :stress_diagnosis, only: [:new, :create]
    resource :happy_diagnosis, only: [:new, :create]
    resources :diary_comments, only: [:create, :update, :destroy], module: :diaries
    resource :favorite, only: [:create, :destroy]
    resource :sympathy, only: [:create, :destroy]
  end

  namespace :mypage do
    get 'profiles/:id', to: 'profiles#view_users'
    resource :profile, only: [:show, :update] do
      resource :avatar, only: [:destroy], module: :profiles
      member do
        get :mymean
        get :bookmarks
        get :mydiary
        get :favorites
        get :stress_chart
        get :happy_chart
        get :like_ranking
        get :like_ranking_in_past_month
        get :like_ranking_in_past_week
        get :sympathy_ranking
        get :sympathy_ranking_in_past_month
        get :sympathy_ranking_in_past_week
      end
    end
  end

  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: [:index, :show, :destroy]
    resources :means, only: [:index, :show, :destroy]
    resources :diaries, only: [:index, :show, :destroy]
    resources :reports, only: [:index, :show, :update]
  end
end
