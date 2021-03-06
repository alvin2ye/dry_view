
# Set the default environment to sqlite3's in_memory database
ENV['RAILS_ENV'] ||= 'in_memory'

# Load the Rails environment and testing framework

require "#{File.dirname(__FILE__)}/app_root/config/environment"
require 'test_help'


# Undo changes to RAILS_ENV
silence_warnings {RAILS_ENV = ENV['RAILS_ENV']}

# Run the migrations
ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate")

# Set default fixture loading properties
ActiveSupport::TestCase.class_eval do
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures = false
  self.fixture_path = "#{File.dirname(__FILE__)}/fixtures"
  
  fixtures :all
end

gem 'josevalim-inherited_resources'
require 'inherited_resources'
require 'inherited_resources/actions'
require 'inherited_resources/base_helpers'
require 'inherited_resources/class_methods'
require 'inherited_resources/url_helpers'
require 'inherited_resources/base'

require '../activerecord_dom_helper/lib/activerecord_dom_helper'
require '../activerecord_dom_helper/init'
gem 'mislav-will_paginate'
require 'will_paginate'

def assert_security_error
  assert_raise(DryView::SecurityError) { yield }
end

def assert_record_not_found
  assert_raise(ActiveRecord::RecordNotFound) { yield }
end
