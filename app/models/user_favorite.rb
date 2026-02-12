class UserFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  
  validates :user_id, uniqueness: { scope: :movie_id } # Each user can favorite a movie only once
end
