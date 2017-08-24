module ApplicationHelper

  def paginator(global_page, paginator_page)
    return paginator_page if global_page < 10
    global_page + paginator_page
  end

  def pagination(c, l)
    current = c
    last = l
    delta = 2
    left = current - delta
    right = current + delta + 1
    range = []
    rangeWithDots = []
    l = nil

    (1..last).each do |i|
      range << i if (i == 1 || i == last || i >= left && i < right)
    end

    range.each do |elem|
      if l
        if (elem - l === 2)
          rangeWithDots << (l+1)
        elsif (elem - l != 1)
          rangeWithDots << '...'
        end
      end
      rangeWithDots << elem
      l = elem
    end
    rangeWithDots
  end
end
