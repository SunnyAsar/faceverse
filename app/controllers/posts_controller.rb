class PostsController < ApplicationController
  def index
    @posts = Post.feed_for(current_user)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created'
    else
      flash[:alert] = 'Unable to create post, try to add content before post'
    end
    redirect_to root_url
  end

  def destroy
    post = Post.find(params[:id])
    res = post.destroy if post.author == current_user
    if res
      flash[:success] = 'Deleted successfully !'
      redirect_to root_url
    else
      flash.now[:alert] = " sorry Not deleted..."
      redirect_to root_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
