class PagesController < ApplicationController
  def show
    render params[:name]
  end

  def index
    @topic = Topic.essences.order("updated_at DESC").last
  end
end
