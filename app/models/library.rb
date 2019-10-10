class Library < ApplicationRecord
    validates :name, presence: true
    validates :location, presence: true
    validates :fine_per_day, presence: true, numericality: true
    validates :borrow_duration, presence: true, numericality: true

end
