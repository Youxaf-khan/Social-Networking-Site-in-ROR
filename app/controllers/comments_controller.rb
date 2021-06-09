class CommentsController < ApplicationController
  before_action :set_post, only: [:update, :create]
  before_action :set_comment, only: [:destroy, :edit, :update]

  def create
    if test
      @comment = @post.comments.create(comment_params.merge({user: current_user}))
      UserMailer.with(user: current_user, post_user: @post.user).post_created.deliver_now
    end

    redirect_to @post
  end

  def edit; end

  def show; end

  def update
    #TODO: update this
    if test
      flash.notice = "You can't edit comments on your own post"
      redirect_to @post

    elsif @comment.update(comment_params)
      redirect_to @post

    else
      render :edit
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

  private

  def set_comment
    @comment = @post.comments.where(id: params[:id], user: current_user.id).first
  end

    def test
    if @post.user == current_user
      flash.notice = "You can't comment on your own post"
      return false
    elsif  @post.comments_limit_reached?
      flash.notice = "A post can't have more than five comments"
      return false
    else
      return true
    end
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
