Rails.application.routes.draw do
  root 'affiliations#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    collection do
      get 'status'
    end
  end
  resources :affiliations, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :time_cards do
    collection do
      get 'all_index'
      post 'all_index'
    end
  end
end