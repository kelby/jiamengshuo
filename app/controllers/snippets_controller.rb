class SnippetsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @topic = Topic.find params[:topic_id]
    @snippets = @topic.snippets.page(params[:page]).per(24)
  end

  def manage_snippets
    @topic = Topic.find params[:topic_id]
    @snippets = @topic.snippets.page(params[:page]).per(24)
  end

  def create
    @topic = Topic.find params[:topic_id]

    @snippet = @topic.snippets.build(snippet_params.merge(user_id: current_user.id))
    if @snippet.save
      @direct_message = DirectMessage.new(from_user_id: current_user.id, content: "#{current_user.username} 申请了你的发单", to_user_id: @topic.user_id)
      @direct_message.save
    end

    redirect_to @topic, notice: "跟单请求提交成功，等待盟主的批准"
  end

  def show
    @snippet = Snippet.find params[:id]
  end

  def approve
    @snippet = Snippet.find params[:id]
    @snippet.approve!
    @snippet.create_activity :approve, owner: current_user, recipient: @snippet.user

    respond_to do |format|
      format.js
    end
  end

  def refuse
    @snippet = Snippet.find params[:id]
    @snippet.refuse!
    @snippet.create_activity :refuse, owner: current_user, recipient: @snippet.user

    respond_to do |format|
      format.js
    end
  end

  private
  def snippet_params
    params.require(:snippet).permit([:name, :spec, :color, :per_price, :quantity, :address, :body])
  end
end
