class CreateWebSeries < ActiveRecord::Migration[8.1]
  def change
    create_table :web_series do |t|
      t.string :title, null: false
      t.text :description
      t.integer :season_number, default: 1
      t.integer :episode_number, default: 1
      t.date :release_date
      t.integer :duration
      t.bigint :genre_id
      t.bigint :user_id
      t.integer :views_count, default: 0
      t.integer :downloads_count, default: 0
      t.boolean :enable_download, default: true
      t.decimal :download_price, precision: 8, scale: 2, default: 0
      t.string :download_quality, default: 'hd'
      t.string :trailer_url
      t.string :poster_url
      t.string :slug
      
      t.timestamps
    end
    
    add_index :web_series, :genre_id
    add_index :web_series, :user_id
    add_index :web_series, :slug, unique: true
    add_index :web_series, :release_date
    add_index :web_series, :season_number
    add_index :web_series, :episode_number
  end
end
