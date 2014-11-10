module TabsHelper
  def tab_ticket_states(tab)
    states = TicketState.where(ticket_states: {id: tab.states})

    content_tag(:td) do
      if states.length > 1
        states.each do |state|
          concat state.name
          concat tag(:br)
        end
      else
        states[0].name
      end
    end
  end
end
