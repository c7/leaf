require 'leaf/view_helpers/link_renderer'

module Leaf
  module ViewHelpers
    class ListRenderer < LinkRenderer
      def to_html
        html = pagination.map do |item|
          "\n    " + tag(:li, (item.is_a?(Fixnum) ?
            page_number(item) :
            send(item)))
        end.join(@options[:separator])
        
        @options[:container] ? html_container(html) : html
      end
      
      def previous_or_next_page(page, text, classname)
        if page
          link(tag(:span, text), page, :class => classname)
        else
          tag(:span, tag(:span, text), :class => classname + ' disabled')
        end
      end
      
      def html_container(html)
        tag(:div, "\n  " + 
          tag(:ul, html + "\n  ") + "\n", container_attributes) + "\n"
      end
      
    private
      def page_number(page)
        unless page == current_page
          link(tag(:span, page), page, :rel => rel_value(page))
        else
          tag(:em, tag(:span, page))
        end
      end
    end
  end
end