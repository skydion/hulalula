class Ticket < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :support
  belongs_to :ticket_state

  validates :username, presence: true, length: { minimum: 3 }
  validates :email, presence: true #, uniqueness: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :subject, presence: true
  validates :problem, presence: true

  scope :states, ->(ids) { joins(:ticket_state).where(ticket_states: { id: ids }) }

  #attr_accessor :uuid

  def current_status
    status = TicketState.find_by(id: self.ticket_state_id)

    if status.nil?
      status = TicketState.find_by(id: TicketState::CUSTOMER)
    end

    status.name
  end

  # def set_uuid
  #     alpha = (:A..:Z).to_a.shuffle[0,9].join
  #     digit = (0..9).to_a.shuffle[0,6].join
  #
  #     self.uuid = alpha[0,3] + digit[0,3] + alpha[3,3] + digit[3,3] + alpha[6,3]
  # end

  def owner_name(owner_id)
    owner_id ? Support.find_by(id: owner_id).login : 'Customer';
  end

  def current_support
    support = Support.find_by(id: support_id)
    support ? support.login : 'Customer'
  end
end
