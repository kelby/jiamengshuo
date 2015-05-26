class AddFromAddressAndToAddressToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :from_address, :string
    add_column :topics, :to_address, :string
  end
end
