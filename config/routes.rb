Rails.application.routes.draw do
  devise_for :users, only: []
  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resource :users, only: [:create] do
      resources :words, only: [:create,:index, :update] do
        get "most_diff", action: :most_diff_word, controller: "words"
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
