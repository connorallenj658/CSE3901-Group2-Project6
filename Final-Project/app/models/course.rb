class Course < ApplicationRecord
    has_many :enrollments, dependent: :destroy
    has_many :users, through: :enrollments
    has_many :presentations, dependent: :destroy

    belongs_to :user

    validates :name, presence: true, length: { maximum: 50}
    validates :description, presence: true, length: { maximum: 200}
    validates :credits, presence: true, numericality: {only_integer: true},
    comparison: {less_than: 10}
end

# Course.new(name: 'Algebra 1', description: 'Introduction to operations', credits: '3')
