class PersonController < InheritedResources::Base
  dry_view

  def set_dry_view_config
    @dry_view.actions = [:index, :show] if params[:user] == "no_permission"
  end
end
