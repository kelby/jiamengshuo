class AddIndexs < ActiveRecord::Migration
  def change
    add_index :topics, [:title,:user_id,:catalog_id]
    add_index :comments, [:user_id, :commentable_id]
    add_index :replies, [:user_id, :comment_id]
    add_index :user_bodies, [:user_id]
    add_index :user_relationships, [:owner_id,:recipient_id]
    add_index :direct_messages, [:to_user_id,:from_user_id]
    add_index :liker_comments, [:liker_id]
    add_index :snippets, [:topic_id,:user_id]
    add_index :topic_and_users, [:topic_id,:user_id]
  end
end
