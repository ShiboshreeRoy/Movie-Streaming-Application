class AddIndexesToMovies < ActiveRecord::Migration[8.1]
  def change
    # Add indexes to movies table
    add_index :movies, :title
    add_index :movies, :genre
    add_index :movies, :release_year
    add_index :movies, :imdb_rating
    add_index :movies, :country
    
    # Add foreign key for genre_id (after creating the column)
    add_column :movies, :genre_id, :bigint
    add_foreign_key :movies, :genres, column: :genre_id
    add_index :movies, :genre_id
  end
end
