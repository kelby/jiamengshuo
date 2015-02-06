class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at desc").page(params[:page] || 1).per(25) # .where(owner_id: current_user.friend_ids, owner_type: "User")
  end
end
