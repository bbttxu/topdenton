Denton::Application.routes.draw do
  match "shows/today" => 'shows#today'
  match "shows/(:date)" => "shows#day", :constraints => { :date => /\d{4}-\d{2}-\d{2}/ }
  match "shows/calendar" => 'shows#index'

  resources :artists

  root :to => 'shows#today'
end
