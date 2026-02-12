class AddPlacementZoneAndPriorityToAds < ActiveRecord::Migration[8.1]
  def change
    add_column :ads, :placement_zone, :integer
    add_column :ads, :priority, :integer
  end
end
