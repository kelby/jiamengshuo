class CreateUserBodies < ActiveRecord::Migration
  def change
    create_table :user_bodies do |t|
      t.integer :gender, default: 0

      t.timestamps null: false
    end
  end
end
