module ApplicationHelper
=begin
  def admin_area(&block)
    concat('<div class="admin">', block.binding)
    block.call
    concat('</div>', block.binding)
  end
=end
end
