# frozen_string_literal: true

require 'will_paginate'
require 'will_paginate/view_helpers'

class CustomLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
  def url(page)
    "/page/#{page}"
  end
end
