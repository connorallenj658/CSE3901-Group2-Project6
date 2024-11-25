class Course < ApplicationRecord
    has_many :users
    has_many :presentations

    validates :name, presence: true, length: { maximum: 100}
    validates :description, presence: true, length: { maximum: 200}
    validates :credits, presence: true, numericality: {only_integer: true},
    comparison: {less_than: 10}
end
