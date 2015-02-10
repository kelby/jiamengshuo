class AddFakerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :faker, :boolean, default: false
  end
end
