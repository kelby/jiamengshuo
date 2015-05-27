class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  authorize_resource

  respond_to :html

  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    @topic = Topic.find(params[:topic_id]) if params[:topic_id]

    @comment = @topic.comments.build(comment_params.merge(user_id: current_user.id))
    if @comment.save
      @comment.create_activity :create, owner: current_user, recipient: @topic.user, parameters: {topic_id: @topic.id}
    end

    redirect_to @topic
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @comment.destroy
    respond_with(@comment)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end
