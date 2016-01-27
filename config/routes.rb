Rails.application.routes.draw do
  resources :cats, except: [:destroy] do
    resources :cat_rental_requests, as: "rentals", path:"rentals", except: [:show,:create,:new]
  end

   #only: [:index, :show, :new, :create,:edit,:update]
  resources :cat_rental_requests, as: "rentals", path: "rentals", only: [:show,:create,:new]
end
