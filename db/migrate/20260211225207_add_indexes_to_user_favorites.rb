class AddIndexesToUserFavorites < ActiveRecord::Migration[8.1]
  def change
    # Add indexes to user_favorites table
    add_index :user_favorites, :user_id unless index_exists?(:user_favorites, :user_id)
    add_index :user_favorites, :movie_id unless index_exists?(:user_favorites, :movie_id)
    add_index :user_favorites, [:user_id, :movie_id], unique: true unless index_exists?(:user_favorites, [:user_id, :movie_id])
  end
end
