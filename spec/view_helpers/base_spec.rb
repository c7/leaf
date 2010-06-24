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
  
  describe "page_entries_info" do
    before :all do
      @array = ('a'..'z').to_a
    end

    def info(params, options = {})
      options[:html] ||= false unless options.key?(:html) and options[:html].nil?
      collection = Hash === params ? @array.paginate(params) : params
      
      I18n.locale = (options.key?(:locale)) ? options[:locale] : :en
      page_entries_info collection, options
    end
    
    it "should display middle results and total count in Swedish" do
      info({:page => 2, :per_page => 5}, 
            :locale => :sv, :plural_name => 'strängarna'
          ).should == "Visar strängarna 6 - 10 av totalt 26"
    end

    it "should output HTML by default in Swedish" do
      info({ :page => 2, :per_page => 5 }, 
             :html => nil, :locale => :sv, :plural_name => 'strängarna'
          ).should == "Visar strängarna <b>6&nbsp;-&nbsp;10</b> av totalt <b>26</b>"
    end

    it "should display shortened end results" do
      info(:page => 7, :per_page => 4).should include_phrase('strings 25 - 26')
    end

    it "should handle longer class names" do
      collection = @array.paginate(:page => 2, :per_page => 5)
      collection.first.stubs(:class).returns(mock('Class', :name => 'ProjectType'))
      info(collection).should include_phrase('project types')
    end

    it "should adjust output for single-page collections" do
      info(('a'..'d').to_a.paginate(:page => 1, :per_page => 5)).should == "Displaying all 4 strings"
      info(['a'].paginate(:page => 1, :per_page => 5)).should == "Displaying 1 string"
    end
  
    it "should display 'no entries found' for empty collections" do
      info([].paginate(:page => 1, :per_page => 5)).should == "No entries found"
    end
  end
end
