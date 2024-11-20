class Evaluation < ApplicationRecord
  belongs_to :presentation
  belongs_to :user # This links the evaluation to the user who submitted it
end
