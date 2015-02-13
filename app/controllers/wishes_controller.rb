class WishesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :got_it, :spurn_it]
  before_action :set_wish, only: [:show, :edit, :update, :destroy, :got_it, :followers_by_user, :checkout_it, :checkin_it]
  authorize_resource

  respond_to :html

  def index
    @active_wish = Wish.active_wish
    @wishes = Wish.index_wishs.page(params[:page] || 1).per(24)

    respond_with(@wishes)
  end

  def show
    respond_with(@wish)
  end

  def new
    @wish = current_user.wishes.build
    respond_with(@wish)
  end

  def edit
  end

  def create
    @wish = current_user.wishes.build(wish_params)

    if @wish.save
      @wish.create_activity :create, owner: current_user
      redirect_to wishes_path
    else
      render :new
    end
  end

  def update
    @wish.update(wish_params)
    respond_with(@wish)
  end

  def destroy
    @wish.destroy
    respond_with(@wish)
  end

  def got_it
    current_user.follow(@wish)
    @wish.create_activity :got_it, owner: current_user, recipient: @wish.user

    respond_to do |format|
      format.js
    end
  end

  def spurn_it
    current_user.stop_following(@wish)
    @wish.create_activity :spurn_it, owner: current_user, recipient: @wish.user

    respond_to do |format|
      format.js
    end
  end

  def checkout_it
    @wish.create_activity :checkout_it, owner: current_user, recipient: @wish.user
  end

  def checkin_it
    @wish.create_activity :checkin_it, owner: current_user, recipient: @wish.user
  end

  def followers_by_user
    @users = @wish.followers_by_type 'User'
  end

  private
    def set_wish
      @wish = Wish.find(params[:id])
    end

    def wish_params
      params.require(:wish).permit(:content)
    end
end
