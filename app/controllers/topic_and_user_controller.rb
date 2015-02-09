class TopicAndUserController < ApplicationController
  before_action :authenticate_user!, only: [:keep, :mark]
  before_action :set_topic, only: [:keep, :mark]
  # authorize_resource

  def mark
    mt = MarkerTopic.new topic_id: @topic.id, user_id: current_user.id
    mt.save

    respond_to do |format|
      format.js
    end
  end

  def keep
    kt = KeeperTopic.new topic_id: @topic.id, user_id: current_user.id
    kt.save

    respond_to do |format|
      format.js
    end
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end
end