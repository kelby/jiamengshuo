class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @posts = Post.page(params[:page]).per(15)
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
      _params = params.require(:post).permit(:title, :icon_fi, :icon_fa, :description, {:sections_attributes => [:id, :heading, :description]})
      _params[:sections_attributes].each{ |_, value| value.merge!(user_id: current_user.id) if value } if _params[:sections_attributes]

      if _params[:icon_fa].present?
        _params[:icon] = _params[:icon_fa]
        _params[:icon_from] = 'fa'
        _params.except!(:icon_fa)
      end

      if _params[:icon_fi].present?
        _params[:icon] = _params[:icon_fi]
        _params[:icon_from] = 'fi'
        _params.except!(:icon_fi)
      end

      _params
    end
end
