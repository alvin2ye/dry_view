module DryViewHelper
  def requires
    params[:actions].to_s == "new" ? @dry_view.create_requires : @dry_view.update_requires
  end

  def label_text(c, options = {})
    required = options[:required] || requires.include?(c)
    req_str = (required ? abbr_tag("*", :title => I18n.t('dry_view.required', :default => "Required")) : nil)
    [resource_class.human_attribute_name(c.to_s), req_str].compact.join(' ')
  end

  def human_name
    resource_class.human_name
  end

  def abbr_tag(cnt, options={})
    cls = options[:class]
    cls = [cls, "abbr"].compact.uniq.join(" ")
    content_tag(:abbr, options) do
      ie? ? content_tag(:span, cnt, options.merge(:class => cls)) : cnt
    end
  end

  def ie?
    request.env['HTTP_USER_AGENT'].to_s.downcase.match("msie 6")
  end
end
