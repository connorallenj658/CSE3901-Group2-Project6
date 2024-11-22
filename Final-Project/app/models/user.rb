class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  enum role: { student: "student", teacher: "teacher"}

  before_save :set_default_role

  has_many :courses

  validates :name, presence:true

  validates :email, presence:true, 
  length:{maximum: 50},
  uniqueness:true,
  format:{with: /\A[a-zA-Z0-9._%+-]+@([a-zA-Z0-9.-]+.)+[a-zA-Z]+\Z/i }

  validates :password, presence:true,
  length: {minimum: 6}

  private

  def set_default_role
    self.role ||= "student"
  end
end
