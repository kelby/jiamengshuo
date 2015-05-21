module UsersHelper
  def cn_for_user_info(info)
    info.present? ? info : "这家伙很懒,什么也没留下~"
  end
end
