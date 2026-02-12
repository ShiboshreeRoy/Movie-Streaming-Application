class AddIndexesToTvShows < ActiveRecord::Migration[8.1]
  def change
    # Add missing columns to tv_shows table (if they don't exist)
    unless column_exists?(:tv_shows, :release_year)
      add_column :tv_shows, :release_year, :integer
    end
    
    unless column_exists?(:tv_shows, :country)
      add_column :tv_shows, :country, :string
    end
    
    # Add indexes to tv_shows table
    add_index :tv_shows, :title unless index_exists?(:tv_shows, :title)
    add_index :tv_shows, :genre unless index_exists?(:tv_shows, :genre)
    add_index :tv_shows, :release_year unless index_exists?(:tv_shows, :release_year)
    add_index :tv_shows, :imdb_rating unless index_exists?(:tv_shows, :imdb_rating)
    add_index :tv_shows, :country unless index_exists?(:tv_shows, :country)
    
    # Add foreign key for genre_id (after creating the column)
    add_column :tv_shows, :genre_id, :bigint unless column_exists?(:tv_shows, :genre_id)
    add_foreign_key :tv_shows, :genres, column: :genre_id unless foreign_key_exists?(:tv_shows, :genres)
    add_index :tv_shows, :genre_id unless index_exists?(:tv_shows, :genre_id)
  end
end
