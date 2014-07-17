class Ticket < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :support
  belongs_to :ticket_state

  validates :username, presence: true, length: { minimum: 3 }
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :subject, presence: true

  def current_status
    #puts '=== current_status: ' + self.ticket_state_id.to_s

    status = TicketState.find_by(id: self.ticket_state_id)

    if status.nil?
      status = TicketState.find_by(id: 1)
    end

    status.name
  end

  def current_support
    #puts '=== current_support: ' + self.support_id.to_s

    support = Support.find_by(id: self.support_id)

    #puts '=== current_support - support: ' + self.support.login

    if !support.nil?
      return support.login
    else
      return 'Customer'
    end
  end

end
