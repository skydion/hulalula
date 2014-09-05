class Support < ActiveRecord::Base
  has_many :tickets
  belongs_to :role

  validates :login, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 } #, confirmation: true
  #validates_confirmation_of :password
  
  validates :email, presence: true, :uniqueness => true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def check_login
    Support.find_by('login = ? and password = ?', login, password)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def login_with_full_name
    "#{login} - " + full_name
  end
end
