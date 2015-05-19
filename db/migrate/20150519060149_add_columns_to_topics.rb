class AddColumnsToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :mode, :integer
    add_column :topics, :invoice, :integer
    add_column :topics, :deadline, :date
    add_column :topics, :rate, :integer
  end
end
