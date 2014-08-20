class NotificationMailer < ActionMailer::Base
  default from: 'taras.brodovych@onapp.com'
  default to: 'onapp@ukr.net'

  def new_comment ticket, comment
    @ticket = ticket
    @comment = comment

    #mail(to: @ticket.email, subject: 'New comment for UUID:' + @ticket.uuid)

    # for testing purposion
    mail(subject: 'New comment for UUID: ' + @ticket.uuid)
  end

  def new_ticket ticket
    @ticket = ticket

    #mail(to: @ticket.email, subject: 'New ticket with UUID:' + @ticket.uuid)

    # for testing purposion
    mail(subject: 'New ticket with UUID: ' + @ticket.uuid)
  end

  def ticket_status_changed ticket
    @ticket = ticket

    #mail(to: @ticket.email, subject: 'New ticket with UUID:' + @ticket.uuid)

    # for testing purposion
    mail(subject: 'Ticket states with UUID: ' + @ticket.uuid + ' is changed')
  end
end
