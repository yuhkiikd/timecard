Rails.application.routes.draw do
  root 'time_cards#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }

  resources :users, only: [:index, :show, :edit] do
    collection do
      get 'status'
    end
  end
  resources :affiliations
  resources :time_cards do
    collection do
      get 'all_index'
      post 'all_index'
    end
  end
end