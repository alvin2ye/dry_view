module DryView
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def dry_view
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
    end
  end
end
