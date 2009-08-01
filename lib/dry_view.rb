module DryView
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def dry_view(options = {})
      before_filter :set_config
      define_method("index") do
        index! do |format|
          format.html { render :template => "/shared/index" if !template_exists?  }
        end
      end

      define_method("show") do
        show! do |format|
          format.html { render :template => "/shared/show" if !template_exists?  }
        end
      end

      define_method("edit") do
        edit! do |format|
          format.html { render :template => "/shared/edit" if !template_exists?  }
        end
      end

      define_method("new") do
        new! do |format|
          format.html { render :template => "/shared/new" if !template_exists?  }
        end
      end

      define_method("update") do
        update! do |success, failure|
          failure.html { render :template => template_exists? ? "edit" : "/shared/edit" }
        end
      end

      define_method("create") do
        create! do |success, failure|
          failure.html { render :template => template_exists? ? "new" : "/shared/new" }
        end
      end

      define_method("set_config") do
        @dry_view = {}
        if options[:columns]
          @dry_view[:columns] = resource_class.columns.select { |i| !options[:columns].select{|c| c.to_s == i.name}.empty? } 
        else 
          @dry_view[:columns] = resource_class.columns.reject { |i| ["id", "created_at", "updated_at"].include?(i.name) }
        end
      end
    end
  end
end
