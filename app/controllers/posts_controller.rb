# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]


  def index
    @post = Post.new
    @like = Like.new
    @posts = Post.feed_for(current_user).paginate(page: params[:page])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created'
      redirect_back fallback_location: root_path
    else
      @posts = Post.feed_for(current_user)
      render 'index'
    end
  end

  def show
    @comment = Comment.new
    @post = Post.find_by_id(params[:id])
    return redirect_to root_url if @post.nil?

    @comments = @post.comments.paginate(page: params[:page])
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
    redirect_back fallback_location: root_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
    require_permission(@post.author)
  end
end
