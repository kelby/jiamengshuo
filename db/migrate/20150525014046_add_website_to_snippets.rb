class AddWebsiteToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :website, :string
  end
end
