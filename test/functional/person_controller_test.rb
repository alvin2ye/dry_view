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
  end

  test 'have record actions' do
    get :index
    assert_tag :tag => "a", :content => "View"
    assert_tag :tag => "a", :content => "Edit"
    assert_tag :tag => "a", :content => "Remove"
  end

  test 'have not record actions' do
    @alvin.update_attributes(:age => 200)
    get :index
    assert_no_tag :tag => "a", :content => "View"
    assert_no_tag :tag => "a", :content => "Edit"
    assert_no_tag :tag => "a", :content => "Remove"
  end

  test 'remove new action in set_dry_view_config ' do
    @alvin.update_attributes(:age => 200)
    get :index
    assert_no_tag :tag => "a", :content => "NewPerson"
  end
end
