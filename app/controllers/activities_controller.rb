class ActivitiesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :messages_count]

  def index
    get_notifications

    @to_my_resource.where(read: false).update_all(read: true)
    @to_my_request.where(read: false).update_all(read: true)
    @follower_to_me.where(read: false).update_all(read: true)
    @direct_messages.where(read: false).update_all(read: true)

    respond_to do |format|
      format.html
      format.js
    end
  end
 
  def messages_count
    get_notifications

    @unread_to_my_resource = @to_my_resource.where(read: false).size
    @unread_to_my_request = @to_my_request.where(read: false).size
    @unread_follower_to_me = @follower_to_me.where(read: false).size
    @unread_direct_messages = @direct_messages.where(read: false).size

    @message_count = @unread_to_my_resource + @unread_to_my_request + @unread_follower_to_me + @unread_direct_messages
    # @message_count = current_user.direct_messages_to_user.not_read.count + PublicActivity::Activity.where(recipient_id: current_user.id, read: false).count
  end

  private

  def get_notifications
    @to_my_resource = PublicActivity::Activity.where(key: ["keeper_topic.keep", "reply.create", "comment.create", "liker_comment.like_it"]).where(recipient_id: current_user.id).where.not(owner_id: current_user.id).page(params[:to_my_resource]).per(15).includes(:owner,:trackable,:recipient).order("id DESC")
    @to_my_request = PublicActivity::Activity.where(key: ["snippet.approve", "snippet.refuse", "snippet.create"]).where(recipient_id: current_user.id).where.not(owner_id: current_user.id).page(params[:to_my_request]).per(15).includes(:owner,:trackable,:recipient).order("id DESC")
    @follower_to_me = PublicActivity::Activity.where(key: "user.follow").where(recipient_id: current_user.id).page(params[:follower_to_me]).per(15).includes(:owner,:trackable,:recipient).order("id DESC")
    @direct_messages = DirectMessage.where(to_user_id: current_user.id).page(params[:direct_messages]).per(15).order("id DESC")
  end
end
