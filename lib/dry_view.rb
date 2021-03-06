require 'inherited_resources'
require 'config'
require 'security_error'

module DryView
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def dry_view(options = {})
      before_filter :set_config
      before_filter :set_dry_view_config
      before_filter :authorize_action

      define_method("index") do
        index! do |format|
          format.html { render :template => "/dry_view_default/index" if !template_exists?  }
        end
      end

      unless options[:except_show]
        define_method("show") do
          raise ActiveRecord::RecordNotFound if resource.respond_to?('allow_show?') && !resource.allow_show?
          show! do |format|
            format.html { render :template => "/dry_view_default/show" if !template_exists?  }
          end
        end
      end

      define_method("edit") do
        raise ActiveRecord::RecordNotFound if resource.respond_to?('allow_edit?') && !resource.allow_edit?
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
        raise DryView::SecurityError if resource.respond_to?('allow_edit?') && !resource.allow_edit?
        update! do |success, failure|
          failure.html { render :template => template_exists? ? "edit" : "/dry_view_default/edit" }
          success.html { redirect_to options[:except_show] ?  collection_url : resource_url }
        end
      end

      define_method("create") do
        create! do |success, failure|
          failure.html { render :template => template_exists? ? "new" : "/dry_view_default/new" }
          success.html { redirect_to options[:except_show] ?  collection_url : resource_url }
        end
      end

      define_method("destroy") do
        raise DryView::SecurityError if resource.respond_to?('allow_destroy?') && !resource.allow_destroy?
        destroy! do |format|
          format.html{ redirect_to collection_url}
        end
      end

      define_method("set_config") do
        @dry_view = Config.new(resource_class, options)
      end

      define_method("set_dry_view_config") do
      end

      define_method("authorize_action") do
        default_action = [:new, :create, :edit, :update, :list, :show, :destroy]
        if default_action.any?{ |act| act.to_s == params[:action]}
          unless @dry_view.actions.any?{ |action| action.to_s == params[:action] }
            raise DryView::SecurityError
          end
        end
      end

      protected
        define_method("collection") do
          get_collection_ivar || set_collection_ivar(end_of_association_chain.paginate(:all, :page => params[:page], :per_page => @dry_view.list[:pre_page] || 50))
        end
    end
  end
end
