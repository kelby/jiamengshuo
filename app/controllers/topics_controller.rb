class TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :change_status, :destroy, :sticking, :followering, :keepering]
  before_action :set_topic, only: [:show, :edit, :update, :change_status, :destroy, :sticking, :followering, :keepering]
  authorize_resource

  authorize_resource

  respond_to :html

  def index
    if params["category"].present?
      case params["category"]
      when 1
        @topics = Topic.pi_fa
      when 2
        @topics = Topic.ding_zhuo
      when 3
        @topics = Topic.hai_tao
      else
        @topics = Topic.all
      end
    elsif params[:freight_source].present?
      @topics = Topic.send(params[:freight_source])
    elsif params[:catalog_id].present?
      catalog = Catalog.find params[:catalog_id]
      @topics = catalog.topics
    elsif params[:user_id]
      user = User.find params[:user_id]
      @topics = user.topics
    else
      @topics = Topic.all
    end

    @topics = @topics.page(params[:page]).per(8).order("updated_at DESC") if @topics.present?

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

  def change_status
    change_to_status = "#{params[:status]}!" if params[:status]
    @topic.send(change_to_status)

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
      params.require(:topic).permit([:title, :body, :catalog_id, :category, :mode, :invoice, :deadline, :rate, :freight_source, :barcode, :status, :tag_list, :website])
    end
end
