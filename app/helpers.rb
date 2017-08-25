require_relative 'custom_link_renderer'

module ApplicationHelper
  def path_info
    request.path_info
  end
end
