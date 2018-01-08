Rails.application.routes.draw do
  root to: 'bookmarks#index'

  resources :bookmarks, except: [:show, :new]
  resource :search, only: :show
end
