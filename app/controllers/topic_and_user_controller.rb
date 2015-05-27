class TopicAndUserController < ApplicationController
  before_action :authenticate_user!, only: [:keep, :mark, :unkeep, :unmark]
  before_action :set_topic, only: [:keep, :mark, :unkeep, :unmark]
  # authorize_resource

  def mark
    mt = MarkerTopic.new topic_id: @topic.id, user_id: current_user.id
    mt.save
    mt.create_activity :mark, owner: current_user, recipient: @topic if user_signed_in? && mt.persisted?

    respond_to do |format|
      format.js
    end
  end

  def unmark
    mt = MarkerTopic.where(topic_id: @topic.id, user_id: current_user.id).first
    mt.create_activity :unmark, owner: current_user, recipient: @topic if user_signed_in? && mt.persisted?
    mt.destroy

    respond_to do |format|
      format.js
    end
  end

  def keep
    kt = KeeperTopic.new topic_id: @topic.id, user_id: current_user.id

    if kt.save
      kt.create_activity :keep, owner: current_user, recipient: @topic.user, parameters: {topic_id: @topic.id}
    end

    respond_to do |format|
      format.js
    end
  end

  def unkeep
    kt = KeeperTopic.where(topic_id: @topic.id, user_id: current_user.id).first
    kt.create_activity :unkeep, owner: current_user, recipient: @topic if user_signed_in? && kt.persisted?
    kt.destroy

    respond_to do |format|
      format.js
    end
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end
end