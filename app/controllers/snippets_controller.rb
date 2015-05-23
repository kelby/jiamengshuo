class SnippetsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @topic = Topic.find params[:topic_id]
    @snippets = @topic.snippets.page(params[:page]).per(24)
  end

  def create
    @topic = Topic.find params[:topic_id]

    @snippet = @topic.snippets.build(snippet_params.merge(user_id: current_user.id))
    @snippet.save

    redirect_to @topic, notice: "创建成功，等待盟主的批准"
  end

  def show
    @snippet = Snippet.find params[:id]
  end

  private
  def snippet_params
    params.require(:snippet).permit([:name, :spec, :color, :per_price, :quantity, :address, :body])
  end
end
