class AddUserIdToMovies < ActiveRecord::Migration[8.1]
  def change
    add_reference :movies, :user, null: true, foreign_key: true
  end
end
