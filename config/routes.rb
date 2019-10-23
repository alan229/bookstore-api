Rails.application.routes.draw do
  resources :publishing_houses
  resources :authors
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resource :github_webhooks, only: :create, defaults: { formats: :json }
  match :github_webhooks, to: 'github_webhooks#handle', via: :all
end
