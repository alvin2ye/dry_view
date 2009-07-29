namespace :dry_view do
  task :install do
    view_dest = File.join(Rails.root, "app", "views", "shared")
    plugin_directory = File.dirname(__FILE__) + '/..' 
    if File.exists?(view_dest)
      raise "Your are exists #{view_dest}"
    end

    directory = File.join(plugin_directory, 'templete', 'shared')
    FileUtils.mkdir(view_dest) unless File.exist?(view_dest)
    FileUtils.cp_r(Dir.glob(directory + '/*.*'), view_dest)

    puts "created:"
    
    Dir.glob("#{view_dest}/*") do |item|
      puts item
    end


    # css 
    css_dest = File.join(Rails.root, "public", "stylesheets", "formtastic.css")
    if File.exists?(css_dest)
      raise "Your are exists #{css_dest}"
    end
    css_source = File.join(plugin_directory, 'templete', 'formtastic.css')
    FileUtils.cp_r(css_source, css_dest)
    puts "created:"
    puts css_dest
    puts 'add to layout '
    puts ' <%= stylesheet_link_tag "formtastic" %> '
  end
end
