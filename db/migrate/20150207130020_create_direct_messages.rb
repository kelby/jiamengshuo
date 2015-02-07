class CreateDirectMessages < ActiveRecord::Migration
  def change
    create_table :direct_messages do |t|
      t.text :content

      t.timestamps null: false
    end
  end
end
