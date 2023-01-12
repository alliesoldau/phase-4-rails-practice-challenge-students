class Instructor < ApplicationRecord
    has_many :students

    validates :name, presence: true
    validates_numericality_of :age, :greater_than_or_equal_to => 18
end
