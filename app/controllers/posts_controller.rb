class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    @sections = @post.sections
    respond_with(@post)
  end

  def new
    @post = Post.new
    3.times do
      section = @post.sections.build
    end

    respond_with(@post)
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    @post.create_activity :create, owner: current_user if @post.persisted?

    respond_with(@post)
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, {:sections_attributes => [:id, :heading, :description]})
    end
end
