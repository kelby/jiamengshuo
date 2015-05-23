class CreateLikerComments < ActiveRecord::Migration
  def change
    create_table :liker_comments do |t|
      t.integer :liker_id
      t.integer :comment_id

      t.timestamps null: false
    end
  end
end
