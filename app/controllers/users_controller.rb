class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit_avatar, :update_avatar]

  def show
    @user = User.find(params[:id])
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
end
