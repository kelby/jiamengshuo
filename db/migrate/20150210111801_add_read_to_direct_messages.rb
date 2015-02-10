class AddReadToDirectMessages < ActiveRecord::Migration
  def change
    add_column :direct_messages, :read, :boolean, default: false
  end
end
