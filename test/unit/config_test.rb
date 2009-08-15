require 'test_helper'
class ConfigTest < Test::Unit::TestCase
  def setup
    @default = DryView::Config.new(Person)

    @sample = DryView::Config.new(Person,
      {
        :columns => [:id, :name, :created_at],
        :actions => [:index, :new],
        :list => {:except_columns => [:created_at]},
        :create => {:except_columns => [:id, :created_at]},
        :update => {:except_columns => [:created_at]},
        :show => {:except_columns => [:id]}
      }
    )

  end

  def test_resource_class
    assert_equal Person, @default.resource_class
  end

  def test_columns
    assert_equal [:name, :email, :age, :birthday], @default.columns
    assert_equal [:id, :name, :created_at], @sample.columns
  end

  def test_actions
    assert_equal [:index, :show, :update, :new, :create, :destroy], @default.actions
    assert_equal [:index, :new], @sample.actions
    assert_equal [:index, :update, :new, :create, :destroy], DryView::Config.new(Person, :except_show => true ).actions
  end

  def test_list_columns
    assert_equal [:name, :email, :age, :birthday], @default.list_columns
    assert_equal [:id, :name], @sample.list_columns
  end

  def test_create_columns
    assert_equal [:name, :email, :age, :birthday], @default.create_columns
    assert_equal [:name], @sample.create_columns
  end

  def test_update_columns
    assert_equal [:name, :email, :age, :birthday], @default.update_columns
    assert_equal [:id, :name], @sample.update_columns
  end

  def test_show_columns
    assert_equal [:name, :email, :age, :birthday], @default.show_columns
    assert_equal [:name, :created_at], @sample.show_columns
  end
end
