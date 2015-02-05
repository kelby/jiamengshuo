class CreateUserRelationships < ActiveRecord::Migration
  def change
    create_table :user_relationships do |t|
      t.integer :owner_id
      t.integer :recipient_id
      t.string :type

      t.timestamps null: false
    end
  end
end
