AutomationTest::Application.routes.draw do
  resources :users

  get "home/index"
  get "home/generic_view" => "home#generic_view"
  get "home/new" => "home#new"
  root :to=>"home#new"
end
