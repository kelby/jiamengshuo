class RenameRelatedByToUserAndTopics < ActiveRecord::Migration
  def change
    rename_column :topic_and_users, :related_by, :type
  end
end
