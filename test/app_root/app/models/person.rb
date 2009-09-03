class Person < ActiveRecord::Base
  def label
    self.name
  end

  def allow_show?
    self.age < 200
  end

  def allow_edit?
    self.age < 200
  end

  def allow_destroy?
    self.age < 200
  end
end
