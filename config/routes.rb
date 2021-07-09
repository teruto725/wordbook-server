Rails.application.routes.draw do
  devise_for :users, only: []
  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resources :users, only: [:create]
    resources :wordbooks, only:[:create,:index,:show,:destroy] do
      resources :words, only: [:create,:index, :update]
      get "most_diff", action: :most_diff_word, controller: "wordbooks"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
