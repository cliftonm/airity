AutomationTest::Application.routes.draw do
  resources :users

  get "home/index"
  get "home/generic_view" => "home#generic_view"
  get "home/new" => "home#new"
  get "test_foundation" => "home#test_foundation"
  get "test_jquery" => "home#test_jquery"
  root :to=>"home#new"
end
