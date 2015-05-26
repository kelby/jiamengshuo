module ApplicationHelper
  def pattern(str)
    pattern = GeoPattern.generate(str)
    pattern.uri_image
  end

  def current_user?(user)
    current_user && current_user == user
  end

  def has_notification?(current_user)
    @to_my_resource = PublicActivity::Activity.where(key: ["keeper_topic.keep", "reply.create", "comment.create", "liker_comment.like_it"]).where.not(owner_id: current_user.id).page(params[:to_my_resource]).per(15)
    @to_my_request = PublicActivity::Activity.where(key: ["snippet.approve", "snippet.refuse"]).where.not(owner_id: current_user.id).page(params[:to_my_request]).per(15)
    @follower_to_me = PublicActivity::Activity.where(key: "user.follow").where(recipient_id: current_user.id).page(params[:follower_to_me]).per(15)
  end
end
