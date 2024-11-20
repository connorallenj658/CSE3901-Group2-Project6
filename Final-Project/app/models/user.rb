class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  enum role: { student: "student", teacher: "teacher" }

  before_save :set_default_role

  private

  def set_default_role
    self.role ||= "student"
  end
end
