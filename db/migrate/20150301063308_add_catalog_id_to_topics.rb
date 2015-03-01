class AddCatalogIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :catalog_id, :integer, default: 1003
  end
end
