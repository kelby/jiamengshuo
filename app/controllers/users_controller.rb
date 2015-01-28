class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all.page(params[:page] || 1).per(32)
  end
end
