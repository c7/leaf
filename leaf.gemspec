Gem::Specification.new do |s|
  s.name          = "leaf"
  s.version       = "0.0.1"
  s.date          = "2010-06-24"
  s.summary       = "Simple Sinatra pagination"
  s.description   = "A really simple pagination library for Sinatra"
  s.has_rdoc      = false
  s.email         = "peter@c7.se"
  s.homepage      = "http://github.com/c7/leaf"
  s.authors       = ["Peter Hellberg"]
  s.licenses      = "MIT-LICENSE"
  
  s.files         = [
    "lib/leaf/array.rb",
    "lib/leaf/collection.rb",
    "lib/leaf/core_ext.rb",
    "lib/leaf/finders/base.rb",
    "lib/leaf/finders/sequel.rb",
    "lib/leaf/finders.rb",
    "lib/leaf/version.rb",
    "lib/leaf/view_helpers/base.rb",
    "lib/leaf/view_helpers/link_renderer.rb",
    "lib/leaf/view_helpers/link_renderer_base.rb",
    "lib/leaf/view_helpers/sinatra.rb",
    "lib/leaf/view_helpers.rb",
    "lib/leaf.rb",
    "MIT-LICENSE",
    "Rakefile",
    "README.markdown"
  ]
  
  s.rubyforge_project = "leaf"
end
