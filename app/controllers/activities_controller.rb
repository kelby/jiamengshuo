class ActivitiesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @to_my_resource = PublicActivity::Activity.where(key: ["keeper_topic.keep", "reply.create", "comment.create", "liker_comment.like_it"]).where.not(owner_id: current_user.id).page(params[:page])
    @to_my_request = PublicActivity::Activity.where(key: ["snippet.approve", "snippet.refuse"]).where.not(owner_id: current_user.id).page(params[:page])
    @follower_to_me = PublicActivity::Activity.where(key: "user.follow").where(recipient_id: current_user.id).page(params[:page])

    if user_signed_in?
      @direct_messages = DirectMessage.where(to_user_id: current_user.id).page(params[:dm_page] || 1).per(15)
      current_user.read_direct_messages(@direct_messages)
    end
  end
end
