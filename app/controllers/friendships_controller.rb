class FriendshipsController < ApplicationController
  def create
    friendship = current_user.direct_friendships.build(friendship_params)
    if friendship.save
      flash[:succes] = 'Frienship created'
    else
      flash[:alert] = 'Error creating the friendship'
    end
    redirect_back fallback_location: friend_requests_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
