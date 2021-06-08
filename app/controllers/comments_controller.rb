class CommentsController < ApplicationController
  before_action :set_post, only: [:update, :create]
  before_action :set_comment, only: [:destroy, :edit, :update]

  def create
    if test
    @comment = @post.comments.create(comment_params.merge({user: current_user}))
    end
    redirect_to @post
  end

  def edit; end

  def show;end

  def update
    if test
      flash.notice = "You can't edit comments on your own post"
      redirect_to @post

    elsif @comment.update(comment_params)
      redirect_to @post

    else
      render 'comments/edit'
    end
  end

  def destroy

    if current_user == @comment.user
     @comment.destroy
     redirect_to root_path
    else

      flash.notice = "This Comment belongs to someone else"
      redirect_to root_path
    end
  end

  def test
    if @post.user == current_user
      flash.notice = "You can't comment on your own post"
      return false
    elsif  @post.comments.count > 4
      byebug
      flash.notice = "A post can't have more than five comments"
      return false
    else
      return true
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
