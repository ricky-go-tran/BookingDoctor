Rails.application.routes.draw do

  root 'homepages#index'
  get 'homepages/index'
  get 'homepages/clinics'
  get 'homepages/services'
  get 'homepages/doctors'
  get 'homepages/blogs'
  get 'homepages/supports'

  namespace :clinic do
    resources :profiles
  end

  namespace :admin do
    get 'users/index'
    get 'users/show'
    resources :profiles, only: %i[index]
    get 'profiles/index'
    get 'profiles/change', to: "profiles#change"
    resources :reports, only: %i[index show edit update]
  end

  namespace :patient do
    resources :profiles
    resources :patients, only: %i[show create new destroy]
    resources :reports, only: %i[index show create new destroy]
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get "/unconfirmation", to: "notice_messages#unconfirmation"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
