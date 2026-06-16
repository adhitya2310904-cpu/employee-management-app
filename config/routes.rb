Rails.application.routes.draw do

  devise_for :users

  resources :employees

  root "employees#index"

end
