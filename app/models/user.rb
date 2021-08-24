class User < ApplicationRecord
    # incorporate the has_secure_password macro to enable password encryption with bcrypt
    has_secure_password

    # validate the user's username to ensure that it is present and unique (no two users can have the same username)
    validates :username, presence: true, uniqueness: true

    # a user has many recipes
    has_many :recipes
end
