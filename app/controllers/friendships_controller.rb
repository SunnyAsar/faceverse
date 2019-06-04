class FriendshipsController < ApplicationController
  
  def create
    current_user.direct_friendships.create(friend_id: user_id)
  end




end
