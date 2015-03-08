class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit_avatar, :update_avatar, :follow, :stop_following, :profile,
                                            :update_basic, :update_settings]
  authorize_resource

  def show
    @user = User.find(params[:id])

    redirect_to users_profile_path and return if current_user == @user

    @teachers = @user.teachers.includes(:recipient)
    @students = @user.students.includes(:recipient)
    @followers = @user.followers

    @direct_message = DirectMessage.new
  end

  def profile
    @user = current_user
    @teachers = UserRelationship.where(recipient_id: current_user.id).includes(:owner)
    @students = UserRelationship.where(owner_id: current_user.id).includes(:recipient)
    @followers = current_user.followers
  end

  def index
    @users = User.desc.page(params[:page] || 1).per(24)
    @catalogs = Catalog.roots
  end

  def edit_avatar
    @user = current_user
  end

  def update_avatar
    @user = current_user

    @user.update_attribute(:avatar, params[:user][:avatar]) if params[:user] && params[:user][:avatar]

    redirect_to @user
  end

  def update_basic
    @user = current_user

    @user.update(basic_params)

    redirect_to @user
  end

  def update_settings
    @user = current_user

    @user.update_attribute(:avatar, settings_params)

    redirect_to @user
  end

  def follow
    @user = User.find params[:user_id]
    current_user.follow @user
    current_user.create_activity :follow, owner: current_user, recipient: @user

    respond_to do |format|
      format.js
    end
  end

  def stop_following
    @user = User.find params[:user_id]
    current_user.stop_following @user
    current_user.create_activity :stop_following, owner: current_user, recipient: @user

    respond_to do |format|
      format.js
    end
  end

  private
  def basic_params
    params.require(:user).permit(:avatar, :username, :info, :tag_list,
                                 user_body_attributes: [:id, :gender, :birth_date, :website, :phone, :weibo, :tqq_weibo]) if params[:user]
  end

  def settings_params
    # params.require(:user).permit(:title, :body, :category, :tag_list, :catalog_id)
  end
end
