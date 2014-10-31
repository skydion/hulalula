class Role < ActiveRecord::Base
  belongs_to :support

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true

  GUEST = 2
end
