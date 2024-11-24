class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  enum role: { student: "student", teacher: "teacher"}

  before_save :set_default_role

  has_many :courses
  has_many :presentations, dependent: :destroy
  
  validates :name, presence:true 

  validates :email, presence:true, 
  length:{maximum: 50},
  uniqueness:true,
  format:{with: /\A[a-zA-Z0-9._%+-]+@([a-zA-Z0-9.-]+.)+[a-zA-Z]+\Z/i }

  validates :password, presence:true,
  length: {minimum: 6}

 
  def teacher?
    role == "teacher"
  end

  def student?
    role == "student"
  end

  def set_default_role
    self.role ||= "student" # Default role is 'student' if no role is provided
  end
end
