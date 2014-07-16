class Ticket < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :support
  belongs_to :ticket_state

  validates :username, presence: true, length: { minimum: 3 }
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :subject, presence: true
end
