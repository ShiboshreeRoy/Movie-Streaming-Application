class AddTrackableFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :sign_in_count, :integer, default: 0
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :last_sign_in_ip, :string
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :string
    
    # Set existing records to default values
    reversible do |dir|
      dir.up do
        User.update_all(sign_in_count: 0) if table_exists?(:users)
      end
    end
  end
end
