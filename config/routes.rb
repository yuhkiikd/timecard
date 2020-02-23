Rails.application.routes.draw do
  root 'affiliations#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  resources :users, only: [:show]
  resources :affiliations, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :time_cards, only: [:index, :show]
end