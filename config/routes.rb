Rails.application.routes.draw do
  namespace :admin do
    get 'report/index'
    get 'report/show'
    get 'report/create'
    get 'report/new'
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :admin do
    resources :reports
  end
end
