namespace :dry_view do
  task :install do
    plugin_directory = File.dirname(__FILE__) + '/..' 

    # css 
    css_dest = File.join(Rails.root, "public", "stylesheets", "formtastic.css")
    if File.exists?(css_dest)
      raise "Your are exists #{css_dest}"
    end
    css_source = File.join(plugin_directory, 'assets', 'stylesheets', 'formtastic.css')
    FileUtils.cp_r(css_source, css_dest)
    puts "created:"
    puts css_dest
    puts 'add to layout '
    puts ' <%= stylesheet_link_tag "formtastic" %> '
  end
end
