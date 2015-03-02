class AddCategoryToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :category, :integer
  end
end
