module DryViewHelper
  def list_columns
    @list_columns ||= resource_class.columns.reject { |i| ["id", "created_at", "updated_at"].include?(i.name) }
  end

  def form_columns
    @form_columns ||= resource_class.columns.reject { |i| ["id", "created_at", "updated_at"].include?(i.name) }
  end

  def show_columns
    @show_columns ||= resource_class.columns.reject { |i| ["id", "created_at", "updated_at"].include?(i.name) }
  end
end   
