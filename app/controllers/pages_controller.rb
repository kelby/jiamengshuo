class PagesController < ApplicationController
  def show
    render params[:name]
  end

  def index
    @topic = Topic.essences.order("updated_at DESC").last
    @activities = PublicActivity::Activity.order("created_at desc").page(params[:pub_page] || 1).per(15)
    @snippet = @topic.snippet
  end
end
