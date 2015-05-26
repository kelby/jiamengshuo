class AddDeletedAtToUserAndTopic < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    add_column :topics, :deleted_at, :datetime
    add_index :topics, :deleted_at

    add_column :catalogs, :deleted_at, :datetime
    add_index :catalogs, :deleted_at
  end
end
