require 'test_helper'

class PersonControllerTest < ActionController::TestCase
  def setup
    @controller  = PersonController.new
    @request     = ActionController::TestRequest.new
    @response    = ActionController::TestResponse.new

    @alvin = Person.create!(:name => "alvin", :email => "alvin.ye.cn@gmail.com", :age => "27", :birthday => "1983-01-01")
  end

  test "index" do
    get :index
    assert_response :success
    assert_tag :tag => "h1", :attributes => {:class => "heading"}
    assert_tag :tag => "a", :content => "View"
  end
end
