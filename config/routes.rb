Denton::Application.routes.draw do


  # constraints { :id => /\d{4}-\d{2}-\d{2}/ } do
  # end

  match "/auth/:provider/callback" => "sessions#create"

  resources :ratings do
    collection do
      post 'reorder'
    end
  end


  resources :foods do
    member do
      get 'rate'
    end
  end

  match "foods/:tag/rate" => 'foods#rate'


  match "/signout" => "sessions#destroy", :as => :signout

  match "calendar" => 'calendars#index'
  # match "shows/calendar" => 'shows#index', :constraints => { :format => /(json)/ }
  # match "shows" => 'shows#index', :constraints => { :format => /(json)/ }
  # match "shows/(:date)" => "shows#day", :constraints => { :date => /\d{4}-\d{2}-\d{2}/, :format => /(json)/ }
  # resources :artists
  # resources :shows

  # root :to => '/public/index.html'
end
