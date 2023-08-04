# frozen_string_literal: true

Rails.application.routes.draw do


  resources :homepages, only: %i[index], path: '' do
    collection do
      get 'clinics'
      get 'clinics/:id', to: 'homepages#clinic_detail'
      get 'clinics/:id/appointment', to: 'homepages#appointment'
      get 'services'
      get 'services/:id', to: 'homepages#service_detail'
      get 'supports'
      get 'direct'
      get 'unauthorization'
    end
  end
  root "homepages#index"

  namespace :clinic do
    resources :appointments, only: %i[index show] do
      collection do
        get 'detail'
      end
      member do
        delete 'cancle'
      end
    end
    resources :statistics, only: %i[index]
    resources :services do
      resources :consumptions, only: %i[create destroy]
    end
    resources :medical_resources, only: %i[index show]
    resources :inventories
    resources :clinic_profiles, only: %i[index new create edit update] do
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
    resources :votes
    resources :medical_resources
    resources :profiles do
      collection do
        get 'detail'
        get 'invalid'
        get 'change'
      end
    end
    resources :medical_records, except: %i[destroy] do
      member do
        delete 'cancle'
      end
    end
    resources :patient_profiles, only: %i[show create new update destroy] do
      collection do
        get 'change'
      end
    end
    resources :reports, only: %i[index show create new destroy]
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get '/unconfirmation', to: 'notice_messages#unconfirmation'
end
