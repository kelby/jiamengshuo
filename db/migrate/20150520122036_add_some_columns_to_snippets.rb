class AddSomeColumnsToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :name, :string
    add_column :snippets, :spec, :string
    add_column :snippets, :color, :string
    add_column :snippets, :per_price, :decimal
    add_column :snippets, :quantity, :integer
    add_column :snippets, :address, :string
  end
end
