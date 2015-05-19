class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.string :access_token
      t.datetime :expires_at

      t.timestamps null: false
    end
  end
end
