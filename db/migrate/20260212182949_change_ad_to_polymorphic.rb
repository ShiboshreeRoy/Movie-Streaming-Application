class ChangeAdToPolymorphic < ActiveRecord::Migration[8.1]
  def change
    add_column :ads, :advertisable_type, :string
    add_column :ads, :advertisable_id, :integer
    
    # Populate the new polymorphic columns with existing movie data
    Ad.where.not(movie_id: nil).find_each do |ad|
      ad.update!(advertisable_type: 'Movie', advertisable_id: ad.movie_id)
    end
    
    # Remove the old movie reference column
    remove_column :ads, :movie_id
  end
end
