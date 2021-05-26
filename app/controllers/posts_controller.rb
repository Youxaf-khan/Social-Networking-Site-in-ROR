class PostsController < ApplicationController
  before_action :find_user, only: [:create]
  before_action :authenticate_user!
  before_action :find_post, only: [:show,:edit,:update,:destroy]
  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post = Post.new

  end

  def create

  @post = @user.posts.new(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show

  end

  def edit

  end

  def update
   if @post.update(post_params)
    redirect_to @post
   else
    render 'edit'
   end
  end

  def destroy
  @user.posts.destroy
  redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def find_user
    @user = current_user
  end

  def post_params

    params.require(:post).permit(:title, :description)
  end

end
