class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  enum role: { student: "student", teacher: "teacher"}

  before_save :set_default_role

  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  has_many :presentations

  
  validates :name, presence:true,
  length:{maximum: 75}

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

# User.new(name: 'Hamilton', email: 'Hamiltonb63@outlook.com', password: '123456')
