class CreateMovies < ActiveRecord::Migration[8.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :genre
      t.integer :duration
      t.integer :release_year
      t.decimal :imdb_rating
      t.string :poster_url
      t.string :trailer_url
      t.string :country
      t.string :director
      t.text :cast

      t.timestamps
    end
  end
end
