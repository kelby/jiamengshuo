class RepliesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_reply, only: [:edit, :update, :destroy]

  respond_to :html

  def new
    @comment = Comment.find params[:comment_id]
    @reply = @comment.replies.build

    respond_to do |format|
      format.html
      format.json
      format.js
    end
  end

  def edit
  end

  def create
    @comment = Comment.find params[:comment_id]
    reply = @comment.replies.build(reply_params.merge(user_id: current_user.id))
    reply.save
    reply.create_activity :create, owner: current_user, recipient: @comment if reply.persisted?

    redirect_to @comment.commentable
  end

  def update
    @reply.update(reply_params)
    respond_with(@reply)
  end

  def destroy
    @reply.destroy
    respond_with(@reply)
  end

  private
    def set_reply
      @reply = Reply.find(params[:id])
    end

    def reply_params
      params.require(:reply).permit(:content)
    end
end
