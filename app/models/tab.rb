class Tab < ActiveRecord::Base
  serialize :states

  validates :name, presence: true, length: { minimum: 3 }
  validates :show, inclusion: {in: [true, false]}

  scope :show, -> { where(show: 1) }
end
