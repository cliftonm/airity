AutomationTest::Application.routes.draw do
  resources :users

  get "home/index"
  get "home/generic_view" => "home#generic_view"
  get "home/new" => "home#new"
  post "/user" => "users#post"
  root :to=>"home#new"
end
