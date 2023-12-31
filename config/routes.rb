# frozen_string_literal: true
require 'sidekiq/web'
Rails.application.routes.draw do

  resource :webhooks, only: %i[create]
  resources :pdfs, except: %i[new create update edit destroy index] do
    member do
      get 'invoice',to: "pdfs#invoice", format: 'pdf'
    end
  end
  resource  :stripe_intents, only: %i[create] do
    collection do
      get 'retrieve'
      put 'update_medical_record'
    end
  end
  resources :homepages, only: %i[index], path: '' do
    member do
      get 'clinics', to: 'homepages#clinic_detail'
      get 'service', to: 'homepages#service_detail'
      get 'clinics/appointment', to: 'homepages#appointment'
    end
    collection do
      get 'clinics'
      get 'services'
      get 'supports'
      get 'direct'
      get 'unauthorization'
    end

  end
  root "homepages#index"

  namespace :clinic do
    resources :pdfs, except: %i[new create update edit destroy index] do
      member do
        get 'invoice', to: "pdfs#invoice", format: 'pdf'
        get 'prescription',to: "pdfs#prescription", format: 'pdf'
      end
    end
    resources :patients, only: %i[index show] do
      member do
        get 'medical_record/detail', to: 'patients#detail_medical_record'
      end
    end
    resources :workspaces, only: %i[index] do
      member do
        get 're_finish'
        put 'cash_payment'
        get 'finish'
        get 're_examination'
      end
    end
    resources :appointments, only: %i[index show] do
      member do
        delete 'cancle'
        put 'progress'
      end
    end
    resources :statistics, only: %i[index]
    resources :services , except: %i[destroy] do
      resources :consumptions, only: %i[create destroy]
    end
    resources :medical_records, only: %i[index show create update]
    resources :medical_resources, only: %i[index show]
    resources :inventories, except: %i[destroy]
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
    mount Sidekiq::Web => "/sidekiq"
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
    resources :payments, only: %i[index new] do
      member do
        get 'payment'
        post 'payment_intent'
      end
    end
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
