class AddViewsAndDownloadsCountToMovies < ActiveRecord::Migration[8.1]
  def change
    add_column :movies, :views_count, :integer, default: 0
    add_column :movies, :downloads_count, :integer, default: 0
    
    # Set existing records to 0
    reversible do |dir|
      dir.up do
        Movie.update_all(views_count: 0, downloads_count: 0) if table_exists?(:movies)
      end
    end
  end
end
