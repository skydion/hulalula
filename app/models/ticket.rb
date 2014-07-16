class Ticket < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :support

  validates :username, presence: true, length: { minimum: 2 }
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :subject, presence: true, length: { minimum: 5 }
end
