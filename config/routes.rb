AutomationTest::Application.routes.draw do
  resources :users

  get "home/index"
  get "home/generic_view" => "home#generic_view"
  get "home/new" => "home#new"
  get "/test2" => "home#test2"

  # post "/user" => "users#create"
  # post "/upload" => "home#upload"
  # post "/upload" => "home#upload"

  root :to=>"home#new"
end
