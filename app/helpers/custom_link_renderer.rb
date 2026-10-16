# frozen_string_literal: true

require 'will_paginate'
require 'will_paginate/view_helpers'

# Custom pagination renderer that maps pages to /page/:number routes.
class CustomLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
  def url(page)
    "/page/#{page}"
  end
end
