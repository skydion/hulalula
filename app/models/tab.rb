class Tab < ActiveRecord::Base
  serialize :states

  validates :name, presence: true, length: { minimum: 3 }

  scope :show, -> { where(show: true) }
end
