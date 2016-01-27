Rails.application.routes.draw do
  resources :cats, except: [:destroy] #only: [:index, :show, :new, :create,:edit,:update]
end
