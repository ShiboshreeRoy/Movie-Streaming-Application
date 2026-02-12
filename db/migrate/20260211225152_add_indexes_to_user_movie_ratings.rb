class AddIndexesToUserMovieRatings < ActiveRecord::Migration[8.1]
  def change
    # Add indexes to user_movie_ratings table
    add_index :user_movie_ratings, :user_id unless index_exists?(:user_movie_ratings, :user_id)
    add_index :user_movie_ratings, :movie_id unless index_exists?(:user_movie_ratings, :movie_id)
    add_index :user_movie_ratings, [:user_id, :movie_id], unique: true unless index_exists?(:user_movie_ratings, [:user_id, :movie_id])
    add_index :user_movie_ratings, :rating unless index_exists?(:user_movie_ratings, :rating)
  end
end
