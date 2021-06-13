class CommentsController < ApplicationController
  before_action :set_post, only: [:update, :create]
  before_action :set_comment, only: [:destroy, :edit, :update]

  def create
    if @post.creator? current_user
      flash[:notice] = "You can't comment on your own post"
    elsif @post.comments_limit_reached?
      flash[:notice] = 'A post can not have more than five comments'
    else
      @comment = @post.comments.create(comment_params.merge({ user: current_user }))
      UserMailer.with(user: current_user, post_user: @post.user).post_created.deliver_now
    end
    redirect_to @post
  end

  def edit
    if @comment.post.creator? current_user
      flash[:notice] = "You can't edit comments on your own post"
      redirect_to root_path
    elsif @comment.not_creator? current_user
      flash[:notice] = 'This Comment belongs to someone else'
      redirect_to root_path
    end
  end

  def show; end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment Updated'
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    if @comment.creator? current_user
      @comment.destroy
      flash[:notice] = 'Comment Deleted!'
    else
      flash[:notice] = 'This Comment belongs to someone else'
    end
    redirect_to root_path
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
