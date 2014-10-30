class TicketState < ActiveRecord::Base
  SUPPORT = 2
  CUSTOMER = 1

  belongs_to :ticket
end
