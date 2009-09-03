ActionController::Routing::Routes.draw do |map|
  map.resources :people, :collection => { :customer_action => :get }
end
