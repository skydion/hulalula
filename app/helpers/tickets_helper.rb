module TicketsHelper
  def unassigned
    # in this array we can late add new ticket_state ID witch we want to display in some cell
    # need create gui to select ids for active cell
    ids = [1, 2]

    # select tickets fields and ticket_states.name field too
    #@unassigned = Ticket.select('*').joins(:ticket_state).where("ticket_states.id IN (?) AND support_id NOT NULL", ids)

    # select only tickets field
    Ticket.joins(:ticket_state).where("ticket_states.id IN (?) AND support_id NOT NULL", ids)
  end

  def onhold
     # in this array we can late add new ticket_state ID witch we want to display in some cell
     # need create gui to select ids for active cell
     ids = [3]

     # select tickets fields and ticket_states.name field too
     #@onhold = Ticket.select('*').joins(:ticket_state).where("ticket_states.id IN (?)", ids)

     # select only tickets field
     Ticket.joins(:ticket_state).where("ticket_states.id IN (?)", ids)
  end

  def closed
     # in this array we can late add new ticket_state ID witch we want to display in some cell
     # need create gui to select ids for active cell
     ids = [4, 5]

     # select tickets fields and ticket_states.name field too
     #@closed = Ticket.select('*').joins(:ticket_state).where("ticket_states.id IN (?)", ids)

     # select only tickets field
     Ticket.joins(:ticket_state).where("ticket_states.id IN (?)", ids)
  end

  def not_closed_ticket?(&block)
    cs = @ticket.current_status
    if (cs != 'Completed') && (cs != 'Cancelled')
      content_tag(:div, &block)
    end
  end
end
