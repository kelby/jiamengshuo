class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.text :body
      t.integer :topic_id

      t.timestamps null: false
    end
  end
end
