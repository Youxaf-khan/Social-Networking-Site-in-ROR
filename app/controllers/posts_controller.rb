  class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit ,:update, :destroy]

    def search
     if params[:search].blank?
     redirect_to(root_path, alert: "Empty field!") and return
     else
      @parameter = params[:search].downcase
      @results = Post.all.where("lower(title) LIKE :search", search: @parameter)
     end
    end

    def index
      @posts = Post.order("created_at DESC")
    end

    def new
      @post = Post.new
    end

    def create
      @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to @post , notice: "Post is created succcessfully."
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
        render :edit
      end
    end

    def destroy
      # TODO: improve this and add instance method
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
