class TicketState < ActiveRecord::Base
  belongs_to :ticket

  SUPPORT = 2
  CUSTOMER = 1
end
