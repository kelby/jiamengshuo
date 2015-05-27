class DirectMessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_direct_message, only: [:edit, :update, :destroy]
  # authorize_resource

  respond_to :html

  def index
    @direct_messages = DirectMessage.all
    respond_with(@direct_messages)
  end

  def create
    @user = User.find params[:direct_message][:to_user_id]
    @direct_message = DirectMessage.new(direct_message_params.merge(from_user_id: current_user.id))
    @direct_message.save

    respond_to do |format|
      format.js
    end
  end

  def update
    @direct_message.update(direct_message_params)
    respond_with(@direct_message)
  end

  def destroy
    @direct_message.destroy
    respond_with(@direct_message)
  end

  private
    def set_direct_message
      @direct_message = DirectMessage.find(params[:id])
    end

    def direct_message_params
      params.require(:direct_message).permit(:content, :to_user_id)
    end
end
