class AddHeadToSections < ActiveRecord::Migration
  def change
    add_column :sections, :head, :integer, default: 2
  end
end
