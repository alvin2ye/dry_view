require 'test_helper'

class PersonControllerTest < ActionController::TestCase
  def setup
    @controller  = PersonController.new
    @request     = ActionController::TestRequest.new
    @response    = ActionController::TestResponse.new
  end

  test "index" do
    get :index
    assert_response :success
    assert_tag :tag => "h1", :attributes => {:class => "heading"}
  end

end
