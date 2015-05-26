class TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :change_status, :destroy, :sticking, :followering, :keepering]
  before_action :set_topic, only: [:show, :edit, :update, :change_status, :destroy, :sticking, :followering, :keepering]
  authorize_resource

  authorize_resource

  respond_to :html

  def index
    @params={};

    if params["category"].present?
      case params["category"]
      when 1
        @topics = Topic.pi_fa
        @params[:category]=1
      when 2
        @topics = Topic.ding_zhuo
        @params[:category]=2
      when 3
        @topics = Topic.hai_tao
        @params[:category]=3
      else
        @topics = Topic.all
      end
    else
      @topics = Topic.all
    end

    if params[:freight_source].present?
      @topics = @topics.send(params[:freight_source])
      @params[:freight_source]=params[:freight_source];
    end

    if params[:catalog_id].present?
      @topics = @topics.where('catalog_id=?',params[:catalog_id].to_i)
      @params[:catalog_id]=params[:catalog_id];
    end

    if params[:user_id].present?
      if params[:from_snippet].present?
        snippets = Snippet.where(user_id: params[:user_id])
        @topics = @topics.where(id: snippets.pluck(:topic_id))
      else
        @topics = @topics.where('user_id=?',params[:user_id].to_i)
        @params[:user_id]=params[:user_id];
      end
    end

    @topics = @topics.page(params[:page]).per(8).order("updated_at DESC").includes(:user,:catalog) if @topics.present?

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

    @snippet_uniq_users = User.where(id: @topic.snippets.pluck(:user_id).uniq)

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
    @params={};
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
      params.require(:topic).permit([:title, :body, :catalog_id, :category, :mode, :invoice, :deadline, :rate, :freight_source, :barcode, :status, :tag_list, :website, :from_address, :to_address])
    end
end
