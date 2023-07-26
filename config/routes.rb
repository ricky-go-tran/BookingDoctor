# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homepages#index'
  get 'homepages/index'
  get 'homepages/clinics'
  get 'homepages/services'
  get 'homepages/doctors'
  get 'homepages/blogs'
  get 'homepages/supports'
  get 'direct', to: 'homepages#direct'

  namespace :clinic do
    resources :clinic_profiles, only: %i[index update] do
      collection do
        get "change"
      end
    end
    resources :profiles, only: %i[index update destroy] do
      collection do
        get 'detail'
        get 'invalid'
        get 'change'
      end
    end
  end

  namespace :admin do
    resources :medical_resources
    resources :categories
    resources :users, only: %i[index show] do
      collection do
        get 'request_verify', to: 'users#request_verify'
        put 'accepted', to: 'users#accepted'
        put 'canceled', to: 'users#canceled'
      end
      member do
        get 'detail_request', to: 'users#detail_request'
      end
    end
    resources :profiles, only: %i[index]
    get 'profiles/index'
    get 'profiles/change', to: 'profiles#change'
    put 'profile/update', to: 'profiles#update'
    resources :reports, only: %i[index show]
  end

  namespace :patient do
    resources :profiles
    resources :patient_profiles, only: %i[show create new destroy]
    resources :reports, only: %i[index show create new destroy]
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get '/unconfirmation', to: 'notice_messages#unconfirmation'
end
