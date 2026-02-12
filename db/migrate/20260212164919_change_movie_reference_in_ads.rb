class ChangeMovieReferenceInAds < ActiveRecord::Migration[8.1]
  def change
    change_column_null :ads, :movie_id, true
  end
end