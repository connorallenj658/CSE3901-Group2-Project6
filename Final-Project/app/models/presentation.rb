class Presentation < ApplicationRecord
  has_many :evaluations, dependent: :destroy
  #validates title and date fields
  validates :title, presence: true, length: { maximum: 100 }
  validates :date, presence: true
end
