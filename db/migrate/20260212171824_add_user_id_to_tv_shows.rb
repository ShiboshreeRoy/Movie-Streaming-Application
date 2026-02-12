class AddUserIdToTvShows < ActiveRecord::Migration[8.1]
  def change
    add_reference :tv_shows, :user, null: true, foreign_key: true
  end
end
