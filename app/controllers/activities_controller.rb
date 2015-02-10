class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at desc").page(params[:pub_page] || 1).per(15)
    @direct_messages = DirectMessage.where(to_user_id: current_user.id).page(params[:dm_page] || 1).per(15)
    current_user.read_direct_messages(@direct_messages)
  end
end
