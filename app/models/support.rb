class Support < ActiveRecord::Base
  has_many :tickets
  belongs_to :role

  validates :login, presence: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 8 }
  
  validates :email, presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def self.present(login, password)
    find_by('login = ? and password = ?', login, password)
  end

  def check_login
    # puts '=== check_login: '
    Support.present(self.login, self.password)
  end
end
