class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at desc").page(params[:page] || 1).per(25)
  end
end
