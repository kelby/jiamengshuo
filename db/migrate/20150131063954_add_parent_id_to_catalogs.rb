class AddParentIdToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :parent_id, :integer
  end
end
