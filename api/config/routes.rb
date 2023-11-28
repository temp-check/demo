Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :postal_codes
      resources :locations
      resources :temperatures

      get "address", to: "address#search"
      post "address", to: "address#search"
    end
  end
end
