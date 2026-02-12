class CreateTvShows < ActiveRecord::Migration[8.1]
  def change
    create_table :tv_shows do |t|
      t.string :title
      t.text :description
      t.string :genre
      t.integer :seasons
      t.integer :episodes
      t.decimal :imdb_rating
      t.string :poster_url
      t.string :trailer_url
      t.string :country

      t.timestamps
    end
  end
end
