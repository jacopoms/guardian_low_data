require 'will_paginate'
require 'will_paginate/view_helpers'

class CustomLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
  def url(page)
    str = request.path_info
    str << "/page/#{page}"
  end

  def request
    @template.request
  end
end
