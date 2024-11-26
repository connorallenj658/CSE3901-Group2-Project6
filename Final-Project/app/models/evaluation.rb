class Evaluation < ApplicationRecord
  belongs_to :presentation
  belongs_to :user # The user who submits the evaluation

  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :comment, presence: true, length: {maximum: 200}
  validate :student_cannot_evaluate_multiple_times

  private

  def student_cannot_evaluate_multiple_times
    if user.student? && Evaluation.exists?(user_id: user.id, presentation_id: presentation_id)
      errors.add(:base, "You have already submitted an evaluation for this presentation.")
    end
  end
end
