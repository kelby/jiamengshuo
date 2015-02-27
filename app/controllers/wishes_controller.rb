class WishesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :got_it, :spurn_it]
  before_action :set_wish, only: [:show, :edit, :update, :destroy, :got_it, :followers_by_user, :checkout_it,
                                  :checkin_it, :spurn_it, :checkin_by_users]
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
    UserWish.find_by(user_id: current_user.id, wish_id: @wish.id).try(:destroy)
    # debugger
    @wish.create_activity :checkout_it, owner: current_user, recipient: @wish.user, parameters: {wish_content: @wish.content}
  end

  def checkin_it
    UserWish.create(user_id: current_user.id, wish_id: @wish.id)
    @wish.create_activity :checkin_it, owner: current_user, recipient: @wish.user
  end

  def followers_by_user
    @users = @wish.followers_by_type('User').page(params[:page] || 1).per(24)
    render "users/index"
  end

  def checkin_by_users
    user_ids = UserWish.where(wish_id: @wish.id).pluck(:user_id)
    @users = User.where(id: user_ids).page(params[:page] || 1).per(24)
    render "users/index"
  end

  private
    def set_wish
      @wish = Wish.find(params[:id])
    end

    def wish_params
      params.require(:wish).permit(:content)
    end
end
