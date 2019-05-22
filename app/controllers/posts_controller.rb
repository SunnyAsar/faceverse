class PostsController < ApplicationController
  def index
    @posts = current_user.posts
    current_user.friends.each do |friend|
      @posts += friend.post
    end
  end
end
