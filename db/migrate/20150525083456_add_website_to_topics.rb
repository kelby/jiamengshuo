class AddWebsiteToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :website, :string
  end
end
