class ChangeStatusToApplies < ActiveRecord::Migration
  def change
    change_column :applies, :status, :integer
  end
end
