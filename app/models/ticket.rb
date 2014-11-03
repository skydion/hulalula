class Ticket < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :support
  belongs_to :ticket_state

  validates :uuid, presence: true
  validates :username, presence: true, length: { minimum: 3 }
  validates :email, presence: true #, uniqueness: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :subject, presence: true
  validates :problem, presence: true

  scope :states, ->(ids) { joins(:ticket_state).where(ticket_states: { id: ids }) }

  before_validation(on: :create) do
    begin
      alpha = (:A..:Z).to_a.shuffle[0,9].join
      digit = (0..9).to_a.shuffle[0,6].join
      self.uuid = alpha[0,3] + digit[0,3] + alpha[3,3] + digit[3,3] + alpha[6,3]
    end while Ticket.where(uuid: self.uuid).first
  end

  def current_status
    status = TicketState.where(id: :ticket_state_id).first

    if status.nil?
      status = TicketState.where(id: TicketState::CUSTOMER).first
    end

    status.name
  end

  def owner_name(owner_id)
    owner_id ? Support.where(id: owner_id).first.login : 'Customer';
  end

  def current_support
    support = Support.where(id: support_id).first
    support ? support.login : 'Customer'
  end
end
