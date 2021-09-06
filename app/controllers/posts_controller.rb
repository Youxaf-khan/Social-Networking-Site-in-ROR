class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit ,:update, :destroy]

  def search
    return if params[:search].blank?

    @parameter = params[:search].downcase
    @results = Post.where('lower(title) LIKE :search', search: @parameter)
  end

  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post is created succcessfully.'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post has been update'
    else
      render :edit
    end
  end

  def destroy
    if @post.not_creator? current_user
      flash[:notice] = 'This post belongs to someone else you are not authorized'
      redirect_to root_path
    elsif @post.destroy
      flash.now[:notice] = 'Post destroyed successfully'
    else
      flash[:notice] = 'Something went wrong'
      redirect_to root_path
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end
end
