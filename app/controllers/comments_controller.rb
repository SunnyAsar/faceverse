class CommentsController < ApplicationController
  before_action :require_permission, only: %i[edit update destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @post = @comment.post
    if @comment.save
      flash[:success] = 'Comment successful'
      redirect_to @post
    else
      render 'posts/show'
    end
  end

  def edit
    @post = @comment.post
  end

  def update
    @post = @comment.post
    if @comment.update_attributes(comment_params)
      flash[:success] = 'comment updated'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = @comment.post
    if @comment.destroy
      flash[:success] = 'Comment deleted'
    else
      flash[:alert] = 'Comment was not deleted'
    end
    redirect_to @post
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  private

  def require_permission
    @comment = Comment.find(params[:id])
    return if @comment.commenter == current_user

    flash[:alert] = 'You have no permission'
    redirect_to @coment.post
  end
end
