class Evaluation < ApplicationRecord
  belongs_to :presentation
  belongs_to :user # This links the evaluation to the user who submitted it

  validates :comment, presence: true
  validates :score, presence: true, numericality: {only_integer: true},
  comparison: {less_than_or_equal_to: 100}
end
