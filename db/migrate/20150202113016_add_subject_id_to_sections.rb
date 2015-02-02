class AddSubjectIdToSections < ActiveRecord::Migration
  def change
    add_column :sections, :subject_id, :integer
  end
end
