require 'test_helper'
class ConfigTest < Test::Unit::TestCase
  def setup
    @default = DryView::Config.new(Person)

    @sample = DryView::Config.new(Person,
      {
        :columns => [:id, :name, :created_at],
        :actions => [:index],
        :list => {:except_columns => [:created_at]},
        :create => {:except_columns => [:id, :created_at], :except_requires => [:id]},
        :update => {:except_columns => [:created_at], :except_requires => [:name]},
        :show => {:except_columns => [:id]},
        :requires => [:id, :name]
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
    assert_equal [:index, :show, :update, :new, :create, :destroy, :edit], @default.actions
    assert_equal [:index], @sample.actions
    assert_equal [:index, :update, :new, :create, :destroy, :edit], DryView::Config.new(Person, :except_show => true ).actions
  end

  def test_has_methods
    assert @default.has_new?
    assert @default.has_show?
    assert @default.has_edit?
    assert @default.has_destroy?
    assert @default.has_record_action?

    assert !@sample.has_new?
    assert !@sample.has_show?
    assert !@sample.has_edit?
    assert !@sample.has_destroy?
    assert !@sample.has_record_action?
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

  def test_requires
    assert_equal [:id, :name], @sample.requires
  end

  def test_requires_default
    @sample.requires = nil
    assert_equal [:id, :name, :created_at], @sample.requires
  end

  def test_create_requires
    assert_equal [:name], @sample.create_requires
  end

  def test_update_requires
    assert_equal [:id], @sample.update_requires
  end
end
