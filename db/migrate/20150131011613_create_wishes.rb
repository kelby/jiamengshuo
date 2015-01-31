class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.string :content

      t.timestamps null: false
    end
  end
end
