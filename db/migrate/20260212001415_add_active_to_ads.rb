class AddActiveToAds < ActiveRecord::Migration[8.1]
  def change
    add_column :ads, :active, :boolean
  end
end
