class TopicAndUserController < ApplicationController
  before_action :authenticate_user!, only: [:sticking, :followering, :keepering]
  before_action :set_topic, only: [:sticking, :followering, :keepering]

  def sticking
    stick = current_user.sticks.build topic_id: @topic.id
    stick.save
  end

  def followering
    follower = current_user.followers.build topic_id: @topic.id
    follower.save
  end

  def keepering
    keeper = current_user.keepers.build topic_id: @topic.id
    keeper.save
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end
end