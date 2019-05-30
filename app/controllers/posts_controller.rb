# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :require_permission, only: %i[edit update destroy]

  def index
    @post = Post.new
    @like = Like.new
    @posts = Post.feed_for(current_user).paginate(page: params[:page])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created'
      redirect_to root_url
    else
      @posts = Post.feed_for(current_user)
      render 'index'
    end
  end

  def show
    @comment = Comment.new
    @post = Post.find(params[:id])
  end

  def edit; end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = 'Post updated'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = 'Deleted successfully !'
    else
      flash[:alert] = 'sorry Not deleted...'
    end
    redirect_to root_url
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def require_permission
    @post = Post.find(params[:id])
    return if @post.author == current_user

    flash[:alert] = 'You have no permission'
    redirect_to root_url
  end
end
