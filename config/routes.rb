Denton::Application.routes.draw do

  match "/auth/:provider/callback" => "sessions#create"

  resources :ratings do
    collection do
      post 'reorder'
    end
  end

  match "/foods/landing" => "foods#landing"
  resources :foods do
    member do
      get 'rate'
    end
  end

  resources :users do
    member do
      post 'toggle'
    end
  end

  match "/signout" => "sessions#destroy", :as => :signout

  root :to => 'foods#landing'
end
