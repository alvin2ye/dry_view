module DryView
  class Config
    IGNORE = ["id", "created_at", "updated_at"]

    attr_accessor :columns, :list, :create, :update, :show, :actions, :requires
    attr :resource_class, :except_show

    def initialize(resource_class, options = {})
      @resource_class = resource_class

      if options[:columns].is_a?(Array)
        @columns = options[:columns] 
      else
        @columns = resource_class.columns.map{ |i| i.name.to_sym }.reject{ |c| IGNORE.include?(c.to_s) }
      end

      if options[:actions].is_a?(Array)
        @actions = options[:actions] 
      else
        @actions = [:index, :show, :update, :new, :create, :destroy, :edit]
        @actions -= [:show] if options[:except_show]
      end

      @list = options[:list] || {}
      @create = options[:create]
      @update = options[:update]
      @show = options[:show]
      @requires = options[:requires]
    end

    def list_columns
      self.columns - list_except_column
    end

    def create_columns
      self.columns - create_except_column
    end

    def show_columns
      self.columns - show_except_column
    end

    def update_columns
      self.columns - update_except_column
    end

    def list_except_column 
      self.list[:except_columns] ?  self.list[:except_columns] : []
    end

    def requires
      @requires || self.columns
    end

    def create_requires
      self.requires - create_except_requires
    end

    def update_requires
      self.requires - update_except_requires
    end

    def create_except_column
      (self.create && self.create[:except_columns]) ?  self.create[:except_columns] : []
    end

    def update_except_column
      (self.update && self.update[:except_columns]) ?  self.update[:except_columns] : []
    end

    def show_except_column
      (self.show && self.show[:except_columns]) ?  self.show[:except_columns] : []
    end

    def create_except_requires
      (self.create && self.create[:except_requires]) ? self.create[:except_requires] : []
    end

    def update_except_requires
      (self.update && self.update[:except_requires]) ? self.update[:except_requires] : []
    end

    def has_record_action?
      has_show? || has_edit? || has_destroy?
    end

    def has_new?
      self.actions.include?(:new)
    end

    def has_show?
      self.actions.include?(:show)
    end

    def has_edit?
      self.actions.include?(:edit)
    end

    def has_destroy?
      self.actions.include?(:destroy)
    end
  end
end
