class CreateAds < ActiveRecord::Migration[8.1]
  def change
    create_table :ads do |t|
      t.references :movie, null: false, foreign_key: true
      t.string :title
      t.string :url
      t.integer :duration
      t.string :position
      t.text :script

      t.timestamps
    end
  end
end
