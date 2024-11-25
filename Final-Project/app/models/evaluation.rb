class Evaluation < ApplicationRecord
  belongs_to :presentation
  belongs_to :user

  validates :score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :comment, presence: true
end
