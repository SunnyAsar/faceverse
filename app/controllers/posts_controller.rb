class PostsController < ApplicationController
  def index
    @posts = current_user.friends.reduce()posts
  end
end
