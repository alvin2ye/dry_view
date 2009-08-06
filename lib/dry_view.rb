module DryView
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def dry_view(options = {})
      before_filter :set_config
      define_method("index") do
        index! do |format|
          format.html { render :template => "/dry_view_default/index" if !template_exists?  }
        end
      end

      define_method("show") do
        show! do |format|
          format.html { render :template => "/dry_view_default/show" if !template_exists?  }
        end
      end

      define_method("edit") do
        edit! do |format|
          format.html { render :template => "/dry_view_default/edit" if !template_exists?  }
        end
      end

      define_method("new") do
        new! do |format|
          format.html { render :template => "/dry_view_default/new" if !template_exists?  }
        end
      end

      define_method("update") do
        update! do |success, failure|
          failure.html { render :template => template_exists? ? "edit" : "/dry_view_default/edit" }
        end
      end

      define_method("create") do
        create! do |success, failure|
          failure.html { render :template => template_exists? ? "new" : "/dry_view_default/new" }
        end
      end

      define_method("set_config") do
        @dry_view = {}
        if options[:columns] && options[:columns].any?
          @dry_view[:columns] = options[:columns].map do |c| 
            resource_class.columns.select { |c1| c1.name == c.to_s }[0]
          end
        else 
          @dry_view[:columns] = resource_class.columns.reject { |i| ["id", "created_at", "updated_at"].include?(i.name) }
        end
      end
    end
  end
end
