class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      t.string :status, default: 0

      t.timestamps null: false
    end
  end
end
