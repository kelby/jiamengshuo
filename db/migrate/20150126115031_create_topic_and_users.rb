class CreateTopicAndUsers < ActiveRecord::Migration
  def change
    create_table :topic_and_users do |t|
      t.integer :topic_id
      t.integer :user_id
      t.string :related_by

      t.timestamps null: false
    end
  end
end
