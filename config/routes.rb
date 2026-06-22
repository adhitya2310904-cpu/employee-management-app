Rails.application.routes.draw do

  devise_for :users

  root "employees#index"
  get "employee_dashboard",
    to: "leave_requests#index"

  resources :employees

  resources :leave_requests do
    member do
      patch :approve
      patch :reject
    end
  end
  resource :profile,
         only: [:show]

end