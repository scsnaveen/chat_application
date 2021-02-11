class AddLastSeenAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_seen_at, :datetime
    add_column :admins, :last_seen_at, :datetime
  end
end
