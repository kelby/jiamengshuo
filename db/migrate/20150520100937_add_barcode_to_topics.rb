class AddBarcodeToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :barcode, :string, null: false
  end
end
