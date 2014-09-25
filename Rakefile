require 'rspec/core/rake_task'
require 'bundler/gem_tasks'
require 'rdoc/task'

# Default directory to look in is `/specs`
# Run with `rake spec`
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color', '--format', 'documentation']
end

task :default => :spec

RDoc::Task.new(:rdoc => "doc", :clobber_rdoc => "doc:clean", :rerdoc => "doc:force") do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title = 'Flat Library Documentation'
  rdoc.main = "README.md"
  rdoc.rdoc_files.include("README.md", "lib/**/*.rb")
end
