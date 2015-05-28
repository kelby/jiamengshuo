module ApplicationHelper
  def pattern(str)
    pattern = GeoPattern.generate(str)
    pattern.uri_image
  end

  def current_user?(user)
    current_user && current_user == user
  end

  def has_unread_notification_count(current_user)
    to_my_resource = PublicActivity::Activity.where(key: ["keeper_topic.keep", "reply.create", "comment.create", "liker_comment.like_it"]).where(recipient_id: current_user.id).where.not(owner_id: current_user.id).where(read: false).size # .page(params[:to_my_resource]).per(15).includes(:owner,:trackable,:recipient).order("id DESC")
    to_my_request = PublicActivity::Activity.where(key: ["snippet.approve", "snippet.refuse", "snippet.create"]).where(recipient_id: current_user.id).where.not(owner_id: current_user.id).where(read: false).size # .page(params[:to_my_request]).per(15).includes(:owner,:trackable,:recipient).order("id DESC")
    follower_to_me = PublicActivity::Activity.where(key: "user.follow").where(recipient_id: current_user.id).where(read: false).size # .page(params[:follower_to_me]).per(15).includes(:owner,:trackable,:recipient).order("id DESC")
    direct_messages = DirectMessage.where(to_user_id: current_user.id).where(read: false).size

    @has_unread_notification_count ||= to_my_resource + to_my_request + follower_to_me + direct_messages
  end
end
