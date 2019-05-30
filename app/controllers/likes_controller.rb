require 'byebug'
class LikesController < ApplicationController

  def create
    @like = current_user.likes.build(like_params)
   if @like.save
    flash[:success] = " Post Liked !"
    redirect_to root_path
   else

   end

  end

  def destroy
    @like = Like.where(likeable_id: like_params[:id]).where(likeable_type: like_params[:likeable_type]).first
    debugger
    @like.destroy
    redirect_back_or(root_url)
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id,:likeable_type)
  end


end
