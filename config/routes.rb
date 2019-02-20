# frozen_string_literal: true

Rails.application.routes.draw do
  get 'links/new'
  get 'links/index'
  root 'application#home'

  devise_for :users
  resources :invitations do
    post :accept, on: :member
    post :reject, on: :member
    post :revoke, on: :member
  end

  resources :communities do
    resources :links
    resources :newsletters do
      post :send_email, on: :member
    end

    get '/invitations', to: 'communities#invitations'
    post '/invitations', to: 'communities#create_invitation'
    get '/invitations/new', to: 'communities#new_invitation'
  end
end
