class AddBarcodeToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :barcode, :string, null: false

    Topic.reset_column_information
    Topic.where(barcode: '').find_each do |topic|
      topic.update_column(:barcode, SecureRandom.hex(8))
    end
  end
end
