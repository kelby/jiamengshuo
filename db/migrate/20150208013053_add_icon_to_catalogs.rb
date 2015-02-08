class AddIconToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :icon, :string
  end
end
