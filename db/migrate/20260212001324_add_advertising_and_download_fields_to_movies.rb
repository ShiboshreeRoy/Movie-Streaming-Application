class AddAdvertisingAndDownloadFieldsToMovies < ActiveRecord::Migration[8.1]
  def change
    add_column :movies, :enable_ads, :boolean
    add_column :movies, :ad_frequency, :integer
    add_column :movies, :enable_download, :boolean
    add_column :movies, :download_quality, :string
    add_column :movies, :download_price, :decimal
  end
end
