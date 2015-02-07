class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit_avatar, :update_avatar, :follow, :stop_following]

  def show
    @user = User.find(params[:id])

    redirect_to users_profile_path and return if current_user == @user

    @teachers = @user.teachers.includes(:recipient)
    @students = @user.students.includes(:recipient)
    @followers = @user.followers
  end

  def profile
    @user = current_user
    @teachers = current_user.teachers.includes(:recipient)
    @students = current_user.students.includes(:recipient)
    @followers = current_user.followers
  end

  def index
    @users = User.all.page(params[:page] || 1).per(24)
    @catalogs = Catalog.roots
  end

  def edit_avatar
    @user = current_user
  end

  def update_avatar
    @user = current_user

    @user.update_attribute(:avatar, params[:user][:avatar])

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
end
