class CommentsController < ApplicationController
  def create
    @commnent = current_user.comments.build(comment_params)
    if @commnent.save
      flash[:success] = 'Comment successful'
      redirect_to @commnent.post
      else
        redirect_to @commnent.post
      end
  end

  def destroy
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
