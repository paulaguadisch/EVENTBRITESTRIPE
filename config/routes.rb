Rails.application.routes.draw do

  root 'events#index'

  resources :events

  devise_for :users

  resources :users

  post '/events/:id/subscribe', to: 'events#subscribe', as: 'subscribe'

end
