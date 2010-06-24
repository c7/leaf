lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'leaf/version'

Gem::Specification.new do |s|
  s.name        = "leaf"
  s.version     = Leaf::VERSION::STRING
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = "Simple Sinatra pagination"
  s.description = "A really simple pagination library for Sinatra"
  s.email       = "peter@c7.se"
  s.homepage    = "http://github.com/c7/leaf"
  s.authors     = ["Peter Hellberg"]
  s.licenses    = "MIT-LICENSE"
  
  s.has_rdoc = true
  s.rdoc_options = ['--main', 'README.rdoc', '--charset=UTF-8']
  s.extra_rdoc_files = ['README.rdoc', 'MIT-LICENSE']
  
  s.files       = Dir.glob("lib/**/*") + 
                  %w(MIT-LICENSE Rakefile README.rdoc)
  
  s.rubyforge_project = "leaf"
  s.add_dependency('rack', '>= 1.2.0')
end
