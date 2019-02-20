Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/pannels')

  resources :pannels, only: [:create, :edit, :update, :index]
end
