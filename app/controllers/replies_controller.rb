class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @replies = Reply.all
    respond_with(@replies)
  end

  def show
    respond_with(@reply)
  end

  def new
    @reply = Reply.new

    respond_to do |format|
      format.html
      format.json
      format.js
    end
  end

  def edit
  end

  def create
    @reply = current_user.replies.build(reply_params)
    @reply.save
    respond_with(@reply)
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
