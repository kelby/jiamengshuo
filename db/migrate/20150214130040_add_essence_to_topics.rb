class AddEssenceToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :essence, :boolean, default: false
  end
end
