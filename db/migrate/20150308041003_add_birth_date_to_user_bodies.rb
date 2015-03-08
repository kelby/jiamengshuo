class AddBirthDateToUserBodies < ActiveRecord::Migration
  def change
    add_column :user_bodies, :birth_date, :datetime
    add_column :user_bodies, :website, :string
    add_column :user_bodies, :phone, :string
    add_column :user_bodies, :weibo, :string
    add_column :user_bodies, :tqq_weibo, :string
  end
end
