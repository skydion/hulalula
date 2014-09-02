module TicketStatesHelper
  def ticket_states_header_data
    if admin?
      content_tag(:header, class: 'index_header') do
        'Ticket states list: '.concat(
            link_to(image_tag('new-icon-24.png'), new_ticket_state_path, class: 'button')
        ).html_safe
      end
    end
  end
end
