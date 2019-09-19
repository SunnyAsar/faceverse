
class FriendRequestsController < ApplicationController
  def index
    @requests = current_user.friends_requesting
  end

  def create
    friend_request = current_user.sent_requests.build(friend_request_params)
    if friend_request.save
      flash[:succes] = 'Friend request sent'
    else
      flash[:alert] = friend_request.errors.full_messages[0]
    end
    redirect_back fallback_location: users_path
  end

  def destroy
    request = FriendRequest.find(params[:id])
    request.destroy
    redirect_back fallback_location: friend_requests_path
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:receiver_id)
  end
end
