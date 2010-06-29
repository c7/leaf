# = Leafing through the pages!
#
# First read about Leaf::Finders::Base, then see
# Leaf::ViewHelpers. The magical array you're handling in-between is
# Leaf::Collection.
#
# Happy paginating!
module Leaf 
  require 'leaf/version'
  
  # Load the helpers for Sinatra
  if defined?(Sinatra)
    require 'leaf/view_helpers/sinatra'
  end
end