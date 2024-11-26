class Presentation < ApplicationRecord
  has_many :evaluations, dependent: :destroy
  belongs_to :user # Each presentation is created by a user
  belongs_to :course

  validates :title, presence: true
  validates :date, presence: true
  validates :description, presence: true
end
