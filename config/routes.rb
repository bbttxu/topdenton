Denton::Application.routes.draw do
  # constraints { :id => /\d{4}-\d{2}-\d{2}/ } do
  # end



  match "shows/calendar" => 'shows#index'
  match "shows" => 'shows#index'
  match "shows/today" => 'shows#today'
  match "shows/(:date)" => "shows#day", :constraints => { :date => /\d{4}-\d{2}-\d{2}/ }
  # resources :artists
  # resources :shows


  root :to => 'shows#index'
end
