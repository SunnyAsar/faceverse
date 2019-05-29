class FriendRequestsController < ApplicationController
  before_action :validate_friendship


  def create
    @friend_request = current_user.Friend_request.build(friend_request_params)
    if friend_request.save

  end

  def destroy
  end

  private

  def friend_request_params
    params.require(:friend).permit(:friend_id)
  end

  def validate_friendship
   current_user.friend?(friend_request_params[:friend_id])
  end

end
