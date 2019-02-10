# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'

  devise_for :users

  resources :communities do
    resources :invitations do
      post :accept, on: :member
      post :reject, on: :member
    end
  end
end
