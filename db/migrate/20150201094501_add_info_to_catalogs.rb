class AddInfoToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :info, :string
  end
end
