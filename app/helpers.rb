require_relative 'custom_link_renderer'

module ApplicationHelper
  def path_info
    '/' if request.path_info == '/search'
    request.path_info
  end
end
