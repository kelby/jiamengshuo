class LikerCommentsController < ApplicationController
  before_action :authenticate_user!, only: [:like_it, :unlike_it]
  before_action :set_comment, only: [:like_it, :unlike_it]

  def like_it
    lc = LikerComment.new comment_id: @comment.id, liker_id: current_user.id
    lc.save
    lc.create_activity :like_it, owner: current_user, recipient: @comment if user_signed_in? && lc.persisted?

    respond_to do |format|
      format.js
    end
  end

  def unlike_it
    lc = LikerComment.where(comment_id: @comment.id, liker_id: current_user.id).first
    lc.create_activity :unlike_it, owner: current_user, recipient: @comment if user_signed_in? && lc.persisted?
    lc.destroy

    respond_to do |format|
      format.js
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end
end