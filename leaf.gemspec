lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'leaf/version'

Gem::Specification.new do |s|
  s.name        = "leaf"
  s.version     = Leaf::VERSION::STRING
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = "Simple pagination library"
  s.description = "A really simple pagination library, heavily based on the agnostic branch of will_paginate"
  s.email       = "peter@c7.se"
  s.homepage    = "http://c7.github.com/leaf/"
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
