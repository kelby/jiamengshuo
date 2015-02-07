class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

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
    @subject = Subject.find(params[:subject_id]) if params[:subject_id]
    commentable = @topic || @subject

    redirect_to(commentable, alert: "只有已登录用户，及导师、学生、同学、朋友可以评论哦 ~") and return if @subject && !can_comment?(@subject)

    @comment = commentable.comments.build(comment_params.merge(user_id: current_user.id))
    @comment.save
    @comment.create_activity :create, owner: current_user, recipient: commentable if @comment.persisted?

    redirect_to commentable
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
