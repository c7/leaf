require 'leaf/core_ext'
require 'leaf/view_helpers'

module Leaf
  module ViewHelpers
    # = The main view helpers module
    #
    # This is the base module which provides the +leaf+ view helper.
    module Base
      # Renders Digg/Flickr-style pagination for a Leaf::Collection object. Nil is
      # returned if there is only one page in total; pagination links aren't needed in that case.
      # 
      # ==== Options
      # * <tt>:class</tt> -- CSS class name for the generated DIV (default: "pagination")
      # * <tt>:previous_label</tt> -- default: "« Previous"
      # * <tt>:next_label</tt> -- default: "Next »"
      # * <tt>:inner_window</tt> -- how many links are shown around the current page (default: 4)
      # * <tt>:outer_window</tt> -- how many links are around the first and the last page (default: 1)
      # * <tt>:separator</tt> -- string separator for page HTML elements (default: single space)
      # * <tt>:param_name</tt> -- parameter name for page number in URLs (default: <tt>:page</tt>)
      # * <tt>:params</tt> -- additional parameters when generating pagination links
      #   (eg. <tt>:controller => "foo", :action => nil</tt>)
      # * <tt>:renderer</tt> -- class name, class or instance of a link renderer (default:
      #   <tt>Leaf::LinkRenderer</tt>)
      # * <tt>:page_links</tt> -- when false, only previous/next links are rendered (default: true)
      # * <tt>:container</tt> -- toggles rendering of the DIV container for pagination links, set to
      #   false only when you are rendering your own pagination markup (default: true)
      # * <tt>:id</tt> -- HTML ID for the container (default: nil). Pass +true+ to have the ID
      #   automatically generated from the class name of objects in collection: for example, paginating
      #   ArticleComment models would yield an ID of "article_comments_pagination".
      #
      # All options beside listed ones are passed as HTML attributes to the container
      # element for pagination links (the DIV). For example:
      # 
      #   <%= leaf @posts, :id => 'leaf_posts' %>
      #
      # ... will result in:
      #
      #   <div class="pagination" id="leaf_posts"> ... </div>
      #
      def leaf(collection, options = {})
        # early exit if there is nothing to render
        return nil unless collection.total_pages > 1
        
        options = Leaf::ViewHelpers.pagination_options.merge(options)
        
        # get the renderer instance
        renderer = case options[:renderer]
        when String
          options[:renderer].constantize.new
        when Class
          options[:renderer].new
        else
          options[:renderer]
        end
        # render HTML for pagination
        renderer.prepare collection, options, self
        renderer.to_html
      end
    end
  end
end
