# frozen_string_literal: true

Rails.application.routes.draw do
  get 'links/new'
  get 'links/index'
  root 'application#home'

  devise_for :users

  resources :communities do
    resources :links
    resources :invitations do
      post :accept, on: :member
      post :reject, on: :member
    end
  end
end
