class AddIconFromToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :icon_from, :integer
  end
end
