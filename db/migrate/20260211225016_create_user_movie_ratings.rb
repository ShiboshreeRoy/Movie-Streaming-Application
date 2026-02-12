class CreateUserMovieRatings < ActiveRecord::Migration[8.1]
  def change
    create_table :user_movie_ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
