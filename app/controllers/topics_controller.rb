class TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :sticking, :followering, :keepering]
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :sticking, :followering, :keepering]

  authorize_resource

  respond_to :html

  def index
    @topics = Topic.page(params[:page]).per(15)
    respond_with(@topics)
  end

  def show
    @comment = @topic.comments.build
    @comments = @topic.comments.reload
    respond_with(@topic)
  end

  def new
    @topic = Topic.new
    respond_with(@topic)
  end

  def edit
  end

  def create
    @topic = current_user.topics.build(topic_params)
    @topic.save!
    @topic.create_activity :create, owner: current_user
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

  private
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title, :body, :tag_list)
    end
end
