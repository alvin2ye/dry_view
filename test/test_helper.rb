require 'test/unit'
require 'rubygems'
ENV["RAILS_ENV"] = "test"
RAILS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '../../..'))

require File.expand_path(File.join(File.dirname(__FILE__), '../../../../config/environment.rb'))

require_dependency 'inherited_resources'
require '../activerecord_dom_helper/init'
# require '../inherited_resources/init'

require 'active_support'
require 'active_support/test_case'
require 'action_controller'
require 'action_controller/test_case'
require 'action_controller/test_process'
require 'init'
 
# I18n.load_path << File.join(File.dirname(__FILE__), 'locales', 'en.yml')
# I18n.reload!
 
class ApplicationController < ActionController::Base; end
ActiveSupport::Dependencies.load_paths << File.expand_path(File.dirname(__FILE__) + '/../lib')
ActionController::Base.view_paths << File.join(File.dirname(__FILE__), "../app", "views")
 
ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/:action/:id'
end

# model
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => "./test/dom_helper_test.sqlite3")
ActiveRecord::Migration.verbose = false
ActiveRecord::Schema.define(:version => 1) do
  create_table :books, :force => true do |t|
    t.string :name
    t.string :price
    t.string :author
  end
  
  create_table :cars, :force => true do |t|
    t.string :name
  end
end
ActiveRecord::Migration.verbose = true
 
class Book < ActiveRecord::Base
end
 
class Car < ActiveRecord::Base
end
 
