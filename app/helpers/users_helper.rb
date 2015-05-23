module UsersHelper
  def cn_for_user_info(info)
    info.present? ? info : "这家伙很懒,什么也没留下~"
  end

  def cn_for_provider(provider)
    case provider
    when :weibo
      "微博"
    when :qq_connect
      "QQ"
    end
  end
end
