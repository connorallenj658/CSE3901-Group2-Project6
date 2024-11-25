class Presentation < ApplicationRecord
  has_many :evaluations, dependent: :destroy
  belongs_to :user # Each presentation is created by a user
  

  validates :title, presence: true
  validates :date, presence: true
  validates :credits, presence: true
  validates :description, presence: true
end
