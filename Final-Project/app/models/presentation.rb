class Presentation < ApplicationRecord
  has_many :evaluations, dependent: :destroy
end
