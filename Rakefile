require 'rake' 
require 'rake/testtask' 
require 'rake/rdoctask' 

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "dry_view"
    s.rubyforge_project = "dry_view"
    s.summary = "dry_view"
    s.email = "alvin.ye.cn@gmail.com"
    s.homepage = "http://github.com/alvin2ye/dry_view"
    s.description = "dry_view"
    s.authors = ['Alvin Ye']
    s.files =  FileList["[A-Z]*", "{lib}/**/*"]
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

desc 'Default: run unit tests.' 
task :default => :test 
 
desc 'Test plugin.' 
Rake::TestTask.new(:test) do |t| 
  t.libs << 'test' 
  t.pattern = 'test/**/*_test.rb' 
  t.verbose = true 
end 
 
