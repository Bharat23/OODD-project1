class Book < ApplicationRecord
    validates :isbn, presence: true, uniqueness: true
    validates :title, presence: true
    validates :author, presence: true
    validates :language, presence: true
    validates :date_published, presence: true
    validates :edition, presence: true
    validates :subject, presence: true
    validates :summary, presence: true
end
