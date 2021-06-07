class CommentsController < ApplicationController
  before_action :set_post, only: [:update, :create]
  before_action :set_comment, only: [:destroy, :edit, :update]

  def create
    if test
    @comment = @post.comments.create(comment_params)
    redirect_to @post
    end
    redirect_to @post
  end

  def edit; end

  def show;end

  def update
    if @post.user == current_user
      flash.notice = "You can't edit comments on your own post"
      redirect_to @post

    elsif @comment.update(comment_params)
      redirect_to @post

    else
      render 'comments/edit'
    end
  end

  def destroy
     @comment.destroy
     redirect_to root_path
  end

  def test
    if @post.user == current_user
      flash.notice = "You can't comment on your own post"
      return false
    else  @post.comments.count > 6
      flash.notice = "A post can't have more than five comments"
      return false
    end


  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
