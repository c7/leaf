module Leaf
  # = Leaf view helpers
  #
  # The main view helper is +leaf+. It renders the pagination links
  # for the given collection.
  #
  # Read more in Leaf::ViewHelpers::Base
  module ViewHelpers
    # ==== Global options for helpers
    #
    # Options for pagination helpers are optional and get their default values
    # from the Leaf::ViewHelpers.pagination_options hash. You can write
    # to this hash to override default options on the global level:
    #
    # Leaf::ViewHelpers.pagination_options[:previous_label] = 'Previous page'
    def self.pagination_options() @pagination_options; end
    # Overrides the default +pagination_options+
    def self.pagination_options=(value) @pagination_options = value; end
    
    self.pagination_options = {
      :class => 'pagination',
      :previous_label => '&#8592; Previous',
      :next_label => 'Next &#8594;',
      :inner_window => 4, # links around the current page
      :outer_window => 1, # links around beginning and end
      :separator => ' ', # single space is friendly to spiders and non-graphic browsers
      :param_name => :page,
      :params => nil,
      :renderer => 'Leaf::ViewHelpers::LinkRenderer',
      :page_links => true,
      :container => true
    }
  end
end