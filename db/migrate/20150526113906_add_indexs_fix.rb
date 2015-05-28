class AddIndexsFix < ActiveRecord::Migration
  def change
    remove_index :topics, [:title,:user_id,:catalog_id]
    remove_index :comments, [:user_id, :commentable_id]
    remove_index :replies, [:user_id, :comment_id]
    remove_index :user_bodies, [:user_id]
    remove_index :user_relationships, [:owner_id,:recipient_id]
    remove_index :direct_messages, [:to_user_id,:from_user_id]
    remove_index :liker_comments, [:liker_id]
    remove_index :snippets, [:topic_id,:user_id]
    remove_index :topic_and_users, [:topic_id,:user_id]


    #fix
    add_index :topics, :title
    add_index :topics, :user_id
    add_index :topics, :catalog_id

    add_index :comments, :user_id
    add_index :comments, :commentable_id

    add_index :replies, :user_id
    add_index :replies, :comment_id

    add_index :user_bodies, :user_id

    add_index :user_relationships, :owner_id
    add_index :user_relationships, :recipient_id

    add_index :direct_messages, :to_user_id
    add_index :direct_messages, :from_user_id

    add_index :liker_comments, :liker_id

    add_index :snippets, :topic_id
    add_index :snippets, :user_id

    add_index :topic_and_users, :topic_id
    add_index :topic_and_users, :user_id

  end
end
