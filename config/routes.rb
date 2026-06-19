Rails.application.routes.draw do

  devise_for :users

  root "employees#index"

  resources :employees

  resources :leave_requests do
    member do
      patch :approve
      patch :reject
    end
  end

end