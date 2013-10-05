App::Application.routes.draw do
  root to: "application#index"
  namespace :api do
    resources :biblebooks, only: :index
  end
end
