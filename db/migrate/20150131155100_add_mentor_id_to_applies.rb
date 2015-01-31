class AddMentorIdToApplies < ActiveRecord::Migration
  def change
    add_column :applies, :mentor_id, :integer
  end
end
