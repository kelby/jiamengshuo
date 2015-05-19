class TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :sticking, :followering, :keepering]
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :sticking, :followering, :keepering]
  authorize_resource

  authorize_resource

  respond_to :html

  def index
    if params["category"].present?
      case params["category"]
      when 1
        @topics = Topic.pi_fa.page(params[:page]).per(15).order("updated_at DESC")
      when 2
        @topics = Topic.ding_zhuo.page(params[:page]).per(15).order("updated_at DESC")
      when 3
        @topics = Topic.hai_tao.page(params[:page]).per(15).order("updated_at DESC")
      else
        @topics = Topic.qi_ta.merge(Topic.where(category: nil)).page(params[:page]).per(15).order("updated_at DESC")
      end
    else
      @topics = Topic.page(params[:page]).per(15).order("updated_at DESC")
    end

    if user_signed_in?
      @users = current_user.recomment_users
    else
      @users = User.where(id: User.where.not(avatar: nil).ids.sample(5))
    end

    respond_with(@topics)
  end

  def show
    @comment = @topic.comments.build
    @comments = @topic.comments.reload
    respond_with(@topic)
  end

  def new
    @topic = Topic.new category: params[:category]
    respond_with(@topic)
  end

  def edit
  end

  def create
    @topic = current_user.topics.build(topic_params)

    @topic.create_activity :create, owner: current_user if @topic.save
    @topic.qi_ta! unless @topic.category

    respond_with(@topic)
  end

  def update
    @topic.update(topic_params)
    respond_with(@topic)
  end

  def destroy
    @topic.destroy
    respond_with(@topic)
  end

  def search
    search = Topic.search do
      fulltext params[:q]

      order_by :score, :desc
    end

    @topics = search.results

    render :index
  end

  def preview
    respond_to do |format|
      format.js
    end
  end

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title, :body, :category, :tag_list, :catalog_id)
    end
end
