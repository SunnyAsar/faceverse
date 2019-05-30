require 'byebug'
class LikesController < ApplicationController
  def create
    current_user.likes.create(like_params)
    redirect_back_or root_url
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    redirect_back_or root_url
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
