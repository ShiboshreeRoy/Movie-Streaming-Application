class UserMovieRating < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  
  validates :rating, presence: true, inclusion: { in: 1..10 }
  validates :user_id, uniqueness: { scope: :movie_id } # Each user can rate a movie only once
end
