class DeletedUselessIndex < ActiveRecord::Migration
  def change
    remove_index :users, :deleted_at
    remove_index :topics, :deleted_at
    remove_index :catalogs, :deleted_at
    remove_index :comments, :deleted_at
  end
end
