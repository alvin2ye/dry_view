require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  def setup
    @controller  = PeopleController.new
    @request     = ActionController::TestRequest.new
    @response    = ActionController::TestResponse.new

    @allow_person = Person.create!(:name => "alvin", :email => "alvin.ye.cn@gmail.com", :age => "27", :birthday => "1983-01-01")
    @not_allow_person = Person.create!(:name => "alvin", :email => "alvin.ye.cn@gmail.com", :age => "200", :birthday => "1983-01-01")
  end

  test "index" do
    get :index
    assert_response :success
    assert_human_name

    assert_tag :tag => "a", :content => "View", :attributes => {:href => /\/#{@allow_person.id}/}
    assert_tag :tag => "a", :content => "Edit", :attributes => {:href => /\/#{@allow_person.id}\/edit/}
    assert_tag :tag => "a", :content => "Remove", :attributes => {:href => /\/#{@allow_person.id}/}

    assert_no_tag :tag => "a", :content => "View", :attributes => {:href => /\/#{@not_allow_person.id}/}
    assert_no_tag :tag => "a", :content => "Edit", :attributes => {:href => /\/#{@not_allow_person.id}\/edit/}
    assert_no_tag :tag => "a", :content => "Remove", :attributes => {:href => /\/#{@not_allow_person.id}/}
  end

  test 'remove new action in set_dry_view_config ' do
    get :index, :user => "no_permission"
    assert_no_tag :tag => "a", :content => "Newpeople"
  end

  test 'has_new action ' do
    get :index
    assert_tag :tag => "a", :attributes => { :href => 'http://test.host/people/new' }
  end

  test 'create' do
    assert_difference("Person.count") do
      post :create
      assert_redirected_to "http://test.host/people/#{Person.last.id}"
    end
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

  test 'new with human name' do
    get :new
    assert_human_name
  end

  test 'edit with human name' do
    get :edit, :id => @allow_person.id
    assert_human_name
  end

  test 'show with human name' do
    get :show, :id => @allow_person.id
    assert_human_name
  end

  test "show success" do
    get :show, :id => @allow_person.id
    assert_response :success
  end

  test "show faidure" do
    assert_record_not_found do
      get :show, :id => @not_allow_person.id
    end
  end

  test "edit success" do
    get :edit, :id => @allow_person.id
    assert_response :success
  end

  test "edit faidure" do
    assert_record_not_found do
      get :edit, :id => @not_allow_person.id
    end
  end

  test "update success" do
    put :update, :id => @allow_person.id
    assert_response :redirect
  end

  test "update faidure" do
    assert_security_error do
      put :update, :id => @not_allow_person.id
    end
  end

  test "destroy success" do
    delete :destroy, :id => @allow_person.id
    assert_response :redirect
  end

  test "destroy faidure" do
    assert_security_error do
      delete :destroy, :id => @not_allow_person.id
    end
  end

  private

     def assert_human_name
       assert_tag :tag => "h1", :attributes => {:class => "heading"}, :content => /custom human name/
     end
end
