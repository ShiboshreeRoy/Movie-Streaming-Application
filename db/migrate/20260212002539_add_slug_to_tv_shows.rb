class AddSlugToTvShows < ActiveRecord::Migration[8.1]
  def change
    add_column :tv_shows, :slug, :string
    add_index :tv_shows, :slug, unique: true
  end
end
