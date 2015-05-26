class ActivitiesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @to_my_resource = PublicActivity::Activity.where(key: ["keeper_topic.keep", "reply.create", "comment.create", "liker_comment.like_it"]).where.not(owner_id: current_user.id).page(params[:to_my_resource]).per(15).includes(:owner,:trackable,:recipient).order("created_at DESC")
    @to_my_request = PublicActivity::Activity.where(key: ["snippet.approve", "snippet.refuse"]).where.not(owner_id: current_user.id).page(params[:to_my_request]).per(15).includes(:owner,:trackable,:recipient).order("created_at DESC")
    @follower_to_me = PublicActivity::Activity.where(key: "user.follow").where(recipient_id: current_user.id).page(params[:follower_to_me]).per(15).includes(:owner,:trackable,:recipient).order("created_at DESC")

    @direct_messages = DirectMessage.where(to_user_id: current_user.id).page(params[:direct_messages]).per(15).order("created_at DESC")
    current_user.read_direct_messages(@direct_messages)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
