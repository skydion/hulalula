class Ticket < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :support
  belongs_to :ticket_state

  validates :username, presence: true, length: { minimum: 3 }
  validates :email, presence: true #, uniqueness: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :subject, presence: true
  validates :problem, presence: true

  def current_status
    status = TicketState.find_by(id: self.ticket_state_id)

    if status.nil?
      status = TicketState.find_by(id: 1)
    end

    status.name
  end

  def current_support
    support = Support.find_by(id: self.support_id)
    support.nil? ? 'Customer' : support.login
  end
end
