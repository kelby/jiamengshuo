class WishesController < ApplicationController
  before_action :set_wish, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @wishes = Wish.all
    respond_with(@wishes)
  end

  def show
    respond_with(@wish)
  end

  def new
    @wish = Wish.new
    respond_with(@wish)
  end

  def edit
  end

  def create
    @wish = Wish.new(wish_params)
    @wish.save
    respond_with(@wish)
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
