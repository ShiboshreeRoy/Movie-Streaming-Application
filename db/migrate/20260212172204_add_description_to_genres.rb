class AddDescriptionToGenres < ActiveRecord::Migration[8.1]
  def change
    add_column :genres, :description, :text
  end
end
