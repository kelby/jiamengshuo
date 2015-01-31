class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :heading
      t.text :body
      t.integer :position
      t.integer :post_id

      t.timestamps null: false
    end
  end
end