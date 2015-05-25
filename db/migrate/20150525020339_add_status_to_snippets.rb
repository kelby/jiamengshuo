class AddStatusToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :status, :integer, default: 0
  end
end
