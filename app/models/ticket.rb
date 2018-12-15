class Ticket < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :support
  belongs_to :ticket_state

  validates :username, presence: true, length: { minimum: 3 }
  validates :email, presence: true # , uniqueness: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :subject, presence: true
  validates :problem, presence: true

  scope :states, ->(ids) { joins(:ticket_state).where('ticket_states.id IN (?)', ids) }

  def current_status
    status = TicketState.find_by(id: ticket_state_id)

    status = TicketState.find_by(id: 1) if status.nil?

    status.name
  end

  def owner_name(owner_id)
    owner_id ? Support.find_by(id: owner_id).login : 'Customer'
  end

  def current_support
    support = Support.find_by(id: support_id)
    support ? support.login : 'Customer'
  end
end
