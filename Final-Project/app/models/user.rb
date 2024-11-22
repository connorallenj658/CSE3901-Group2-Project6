<<<<<<< HEAD
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  enum role: { student: "student", teacher: "teacher"}

  before_save :set_default_role

  has_many :courses

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
=======
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  enum role: { student: "student", teacher: "teacher"}

  before_save :set_default_role

  has_many :courses
  
  validates :name, presence:true, 

  validates :email, presence:true, 
  length:{maximum: 50},
  uniqueness:true,
  format:{with: /\A\w+\.\d+@\w+\.\w+\Z/i }

  validates :encrypted_password, presence:true,
  length: {minimum: 6}

  private

  def set_default_role
    self.role ||= "student"
  end
end
>>>>>>> 7c2aa93451ecfab2cf9ef62d486d84dd41b80851
