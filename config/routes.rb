# frozen_string_literal: true

Rails.application.routes.draw do
  root 'communities#index'
  get 'links/new'
  get 'links/index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :invitations do
    post :accept, on: :member
    post :reject, on: :member
  end

  resources :communities do
    resources :links
    resources :newsletters do
      post :send_email, on: :member
    end
    get '/users', to: 'communities#users'
    get '/invitations', to: 'communities#invitations'
    post '/invitations', to: 'communities#create_invitation'
    get '/invitations/new', to: 'communities#new_invitation'
    post '/invitations/:id/revoke', to: 'communities#revoke_invitation'
  end
end
