class WishesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_wish, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @wishes = Wish.page(params[:page] || 1).per(24)
    @active_wish = Wish.active_wish

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

  private
    def set_wish
      @wish = Wish.find(params[:id])
    end

    def wish_params
      params.require(:wish).permit(:content)
    end
end
