Rails.application.routes.draw do
  resources :affiliations, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :users
end