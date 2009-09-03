require 'test_helper'

class PersonControllerTest < ActionController::TestCase
  def setup
    @controller  = PersonController.new
    @request     = ActionController::TestRequest.new
    @response    = ActionController::TestResponse.new

    @no_permission = Person.create!(:name => "alvin", :email => "alvin.ye.cn@gmail.com", :age => "27", :birthday => "1983-01-01")
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
    @no_permission.update_attributes(:age => 200)
    get :index
    assert_no_tag :tag => "a", :content => "View"
    assert_no_tag :tag => "a", :content => "Edit"
    assert_no_tag :tag => "a", :content => "Remove"
  end

  test 'remove new action in set_dry_view_config ' do
    @no_permission.update_attributes(:age => 200)
    get :index, :user => "no_permission"
    assert_no_tag :tag => "a", :content => "NewPerson"
  end

  test 'has_new action ' do
    get :index
    assert_tag :tag => "a", :content => "NewPerson"
  end

  test 'create' do
    post :create
    assert_redirected_to "http://test.host/people/2"
  end

  test 'no permission create' do
    assert_raise(RuntimeError) do 
      post :create, :user => "no_permission"
    end
  end
end
