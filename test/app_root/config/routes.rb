ActionController::Routing::Routes.draw do |map|
  map.resources :person, :collection => { :customer_action => :get }
end
