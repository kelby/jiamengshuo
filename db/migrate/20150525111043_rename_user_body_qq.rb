class RenameUserBodyQq < ActiveRecord::Migration
  def change
    change_table :user_bodies do |t|
        t.rename :tqq_weibo, :qq
    end
  end
end
