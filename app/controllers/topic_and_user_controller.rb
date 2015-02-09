class TopicAndUserController < ApplicationController
  before_action :authenticate_user!, only: [:keep, :mark]
  before_action :set_topic, only: [:keep, :mark]
  # authorize_resource

  def mark
    mt = MarkerTopic.new topic_id: @topic.id, user_id: current_user.id
    mt.save
    mt.create_activity :mark, owner: current_user, recipient: @topic if user_signed_in? && mt.persisted?

    respond_to do |format|
      format.js
    end
  end

  def keep
    kt = KeeperTopic.new topic_id: @topic.id, user_id: current_user.id
    kt.save
    kt.create_activity :keep, owner: current_user, recipient: @topic if user_signed_in? && kt.persisted?

    respond_to do |format|
      format.js
    end
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end
end