class Course < ApplicationRecord
    has_many :users
    has_many :presentations

    validates :name, presence: true, length: { maximum: 20}
end
