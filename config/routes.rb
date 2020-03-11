Rails.application.routes.draw do
  root 'time_cards#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
<<<<<<< HEAD

  resources :users, only: [:index, :show, :edit] do
=======
  resources :users, only: [:show] do
>>>>>>> parent of 65a3660... 100_ユーザー情報の更新途中
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