class Recipe < ApplicationRecord
    # title must be present
    validates :title, presence: true

    # instructions must be present and at least 50 characters long
    validates :instructions, length: { minimum: 50 }

    belongs_to :user
end
