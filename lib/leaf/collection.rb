module Leaf
  # = Invalid page number error
  # This is an ArgumentError raised in case a page was requested that is either
  # zero or negative number. You should decide how do deal with such errors in
  # the controller.
  class InvalidPage < ArgumentError
    def initialize(page, page_num)
      super "#{page.inspect} given as value, which translates to '#{page_num}' as page number"
    end
  end
  
  # = The key to pagination
  # Arrays returned from paginating finds are, in fact, instances of this little
  # class. You may think of Leaf::Collection as an ordinary array with
  # some extra properties. Those properties are used by view helpers to generate
  # correct page links.
  #
  #   gem 'leaf'
  #   require 'leaf/collection'
  #   
  #   # now use Leaf::Collection directly or subclass it
  class Collection < Array
    attr_reader :current_page, :per_page, :total_entries, :total_pages

    # Arguments to the constructor are the current page number, per-page limit
    # and the total number of entries. The last argument is optional because it
    # is best to do lazy counting; in other words, count *conditionally* after
    # populating the collection using the +replace+ method.
    def initialize(page, per_page, total = nil)
      @current_page = page.to_i
      raise InvalidPage.new(page, @current_page) if @current_page < 1
      @per_page = per_page.to_i
      raise ArgumentError, "`per_page` setting cannot be less than 1 (#{@per_page} given)" if @per_page < 1
      
      self.total_entries = total if total
    end

    # Just like +new+, but yields the object after instantiation and returns it
    # afterwards. This is very useful for manual pagination:
    def self.create(page, per_page, total = nil, &block)
      pager = new(page, per_page, total)
      yield pager
      pager
    end

    # Helper method that is true when someone tries to fetch a page with a
    # larger number than the last page. Can be used in combination with flashes
    # and redirecting.
    def out_of_bounds?
      current_page > total_pages
    end

    # Current offset of the paginated collection. If we're on the first page,
    # it is always 0. If we're on the 2nd page and there are 30 entries per page,
    # the offset is 30. This property is useful if you want to render ordinals
    # besides your records: simply start with offset + 1.
    def offset
      (current_page - 1) * per_page
    end

    # current_page - 1 or nil if there is no previous page
    def previous_page
      current_page > 1 ? (current_page - 1) : nil
    end

    # current_page + 1 or nil if there is no next page
    def next_page
      current_page < total_pages ? (current_page + 1) : nil
    end

    def total_entries=(number)
      @total_entries = number.to_i
      @total_pages   = (@total_entries / per_page.to_f).ceil
    end

    # This is a magic wrapper for the original Array#replace method. It serves
    # for populating the paginated collection after initialization.
    #
    # Why magic? Because it tries to guess the total number of entries judging
    # by the size of given array. If it is shorter than +per_page+ limit, then we
    # know we're on the last page. This trick is very useful for avoiding
    # unnecessary hits to the database to do the counting after we fetched the
    # data for the current page.
    #
    # However, after using +replace+ you should always test the value of
    # +total_entries+ and set it to a proper value if it's +nil+. See the example
    # in +create+.
    def replace(array)
      result = super
      
      # The collection is shorter then page limit? Rejoice, because
      # then we know that we are on the last page!
      if total_entries.nil? and length < per_page and (current_page == 1 or length > 0)
        self.total_entries = offset + length
      end

      result
    end
  end
end
