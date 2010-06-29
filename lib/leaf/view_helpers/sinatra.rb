require 'leaf/view_helpers/base'
require 'leaf/view_helpers/link_renderer'
require 'leaf/view_helpers/list_renderer'

Leaf::ViewHelpers::LinkRenderer.class_eval do
  protected
  def url(page)
    url = @template.request.url
    if page == 1
      # strip out page param and trailing ? and & if they exists
      url.gsub(/(\?|\&)page=[0-9]+/, '').gsub(/\?$/, '').gsub(/\&$/, '')
    else
      if url =~ /(\?|\&)page=[0-9]+/
        url.gsub(/page=[0-9]+/, "page=#{page}").gsub(/\&+/, '&')
      else
        (url =~ /\?/) ? url + "&page=#{page}" : url + "?page=#{page}"
      end
    end
  end
end
