require 'rubygems'
gem 'rdoc' # Required on Mac OS X to get a “working” rdoc version
require 'rake/rdoctask'

load 'spec/tasks.rake'

desc 'Default: run specs.'
task :default => :spec

desc 'Generate RDoc documentation for the leaf gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_files.include('README.rdoc', 'MIT-LICENSE').
    include('lib/**/*.rb').
    exclude('lib/will_paginate/finders/sequel.rb').
    exclude('lib/will_paginate/view_helpers/sinatra.rb').
    exclude('lib/will_paginate/core_ext.rb').
    exclude('lib/will_paginate/version.rb')
  
  rdoc.main = "README.rdoc" # page to start on
  rdoc.title = "leaf documentation"
  
  rdoc.rdoc_dir = 'doc' # rdoc output folder
  rdoc.options << '--inline-source' << '--charset=UTF-8' << '--format=darkfish'
  rdoc.options << '--main=README.rdoc'
  rdoc.options << '--webcvs=http://github.com/c7/leaf/tree/master/'
end
