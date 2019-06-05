class PostsController < ApplicationController
  # before_action :set_post, only: [:edit, :update, :destroy]
  # before_action :require_permission, only: :destroy

  def index
    @posts = Post.feed_for(current_user)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created'
      redirect_to root_url
    else
      flash.now[:alert] = 'Unable to create post, try to add content before post'
      @posts = Post.feed_for(current_user)
      render 'index'
    end
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

  def set_post
    @post = Post.find(params[:id])
  end

  def require_permission
    if current_user != @post.user
      redirect_to root_path
    end
  end
  
end
