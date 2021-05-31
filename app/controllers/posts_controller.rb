    class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit ,:update, :destroy]

    def index
      @posts = Post.all.order("created_at DESC")
    end

    def new
      @post = Post.new
    end

    def create
      @user = current_user
      @post = @user.posts.new(post_params)

      if @post.save
        redirect_to @post
      else
        render :new
      end
    end

    def show; end

    def edit; end

    def update
     if @post.update(post_params)
      redirect_to @post
     else
      render 'edit'
     end
    end

    def destroy
      if @post.user == current_user
      @post.destroy
      redirect_to root_path
      else
        flash.notice = "This post belongs to someone else you are not authorized"
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
