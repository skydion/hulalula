module TicketsHelper
  def not_closed_ticket?(&block)
    cs = @ticket.current_status.downcase
    if (cs != 'completed') && (cs != 'cancelled')
      content_tag(:div, &block)
    end
  end

  def css_class
    @cells.length == 4 ? 'cell' : 'tab'
  end
end
