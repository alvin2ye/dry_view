require File.join(File.dirname(__FILE__), "./test_helper")

class BooksController < InheritedResources::Base
  dry_view
end

class BooksControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_response :success
  end
end 
