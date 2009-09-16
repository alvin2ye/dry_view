ActionController::Base.send :include, DryView
ActionController::Base.helper DryViewHelper

require "#{File.dirname(__FILE__)}/lib/security_error"
