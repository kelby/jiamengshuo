class CreateAdminCatalogs < ActiveRecord::Migration
  def change
    create_table :admin_catalogs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
