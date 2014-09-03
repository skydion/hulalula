module TicketStatesHelper
  def ticket_states_header_data
    content_tag(:header, class: 'index_header') do
      content_tag(:span, class: 'index_header_text') do
        html = 'Ticket states list: '
        if admin?
          html.concat(
              link_to(image_tag('new-icon-24.png'), new_ticket_state_path, class: 'button')
          ).html_safe
        end
        html
      end
    end
  end
end
