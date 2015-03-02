class PagesController < ApplicationController
  def show
    render params[:name]
  end

  def index
    @topic = Topic.essences.order("updated_at DESC").last
    condition = {key: ["user.follow", "user.stop_following", "user.create",
      "apply.approve_apply", "apply.refuse_apply", "apply.create",
      "reply.create",
      "keeper_topic.keep", "marker_topic.mark", "keeper_topic.unkeep", "marker_topic.unmark",
      "wish.spurn_it", "wish.checkout_it", "wish.checkin_it", "wish.got_it"
      ]}
    @activities = PublicActivity::Activity.order("created_at desc").page(params[:pub_page] || 1).per(15).where.not(condition)
    @snippet = @topic.snippet
  end
end
