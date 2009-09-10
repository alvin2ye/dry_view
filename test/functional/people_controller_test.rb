require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  def setup
    @controller  = PeopleController.new
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
    assert_no_tag :tag => "a", :content => "Newpeople"
  end

  test 'has_new action ' do
    get :index
    assert_tag :tag => "a", :attributes => { :href => 'http://test.host/people/new' }
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

  test 'allow customer action' do
    get :customer_action
    assert_response :success
  end

  test 'index with human name' do
    get :index
    assert_human_name
  end

  test 'new with human name' do
    get :new
    assert_human_name
  end

  test 'edit with human name' do
    get :edit, :id => Person.first.id
    assert_human_name
  end

  test 'show with human name' do
    get :show, :id => Person.first.id
    assert_human_name
  end

  test "edit success" do
    get :edit, :id => @no_permission.id
    assert_response :success
  end

  test "edit faidure" do
    @no_permission.update_attributes!(:age => 200)
    assert_record_not_found do
      get :edit, :id => @no_permission.id
    end
  end

  test "update success" do
    put :update, :id => @no_permission.id
    assert_response :redirect
  end

  test "update faidure" do
    @no_permission.update_attributes!(:age => 200)
    assert_security_error do
      put :update, :id => @no_permission.id
    end
  end

  test "destroy success" do
    delete :destroy, :id => @no_permission.id
    assert_response :redirect
  end

  test "destroy faidure" do
    @no_permission.update_attributes!(:age => 200)
    assert_security_error do
      delete :destroy, :id => @no_permission.id
    end
  end

  private

     def assert_human_name
       assert_tag :tag => "h1", :attributes => {:class => "heading"}, :content => /custom human name/
     end
end
