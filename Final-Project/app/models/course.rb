class Course < ApplicationRecord
    has_many :users

    validates :teacher, presence: true, length: { maximum: 100 }
    validates :students, presence: true
end
