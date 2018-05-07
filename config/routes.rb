Rails.application.routes.draw do

  root 'events#show'

  resources :events

  devise_for :users

  resources :users
end
