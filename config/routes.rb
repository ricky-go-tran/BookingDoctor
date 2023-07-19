Rails.application.routes.draw do
  namespace :clinic do
    resources :profiles
  end

  namespace :admin do
    resources :profiles
    resources :reports, only: %i[index show edit update]
  end

  namespace :patient do
    resources :profiles
    resources :patients, only: %i[show create new destroy]
    resources :reports, only: %i[index show create new destroy]
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
