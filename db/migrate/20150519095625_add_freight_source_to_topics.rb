class AddFreightSourceToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :freight_source, :integer
  end
end
