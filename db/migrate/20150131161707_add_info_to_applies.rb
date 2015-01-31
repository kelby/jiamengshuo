class AddInfoToApplies < ActiveRecord::Migration
  def change
    add_column :applies, :info, :string
  end
end
