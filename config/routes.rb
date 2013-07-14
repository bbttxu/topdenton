Denton::Application.routes.draw do
  match "shows/today" => 'shows#today'
  # constraints { :id => /\d{4}-\d{2}-\d{2}/ } do
    match "show/(:id)" => "shows#day", :constraints => { :date => /\d{4}-\d{2}-\d{2}/ }
  # end
  match "shows/calendar" => 'shows#index'
  resources :artists
  resources :shows


  root :to => 'shows#today'
end
