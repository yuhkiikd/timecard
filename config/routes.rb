Rails.application.routes.draw do
  root 'time_cards#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  devise_scope :user do
    get 'users/:id/edit' => 'users/registrations#edit', as: :edit_other_user_registration
    match 'users/:id', to: 'users/registrations#update', via: [:patch, :put], as: :other_user_registration
  end
  resources :users, only: [:index, :show, :destroy] do
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