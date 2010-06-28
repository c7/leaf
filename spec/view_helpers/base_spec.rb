require 'spec_helper'
require 'leaf/view_helpers/base'
require 'leaf/array'

describe Leaf::ViewHelpers::Base do
  include Leaf::ViewHelpers::Base
  
  describe "leaf" do
    it "should render" do
      collection = Leaf::Collection.new(1, 2, 4)
      renderer   = mock 'Renderer'
      renderer.expects(:prepare).with(collection, instance_of(Hash), self)
      renderer.expects(:to_html).returns('<PAGES>')
      
      leaf(collection, :renderer => renderer).should == '<PAGES>'
    end
    
    it "should return nil for single-page collections" do
      collection = mock 'Collection', :total_pages => 1
      leaf(collection).should be_nil
    end
  end
end
