class PostsController < ApplicationController
  def index
    ids = current_user.friends.pluck(:id) << current_user.id
    @posts = Post.where(author_id: ids)
  end
end
