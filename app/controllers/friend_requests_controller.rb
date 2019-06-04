
class FriendRequestsController < ApplicationController
  before_action :validate_creation, only: :create

  def index
    @requests = current_user.friend_requests
  end

  def create
    friend_request = current_user.sent_requests.build(friend_request_params)
    if friend_request.save
      flash[:succes] = 'Friend request sent'
    else
      flash[:alert] = 'Unable to send request'
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

  def validate_creation
    return unless current_user.friend?(@receiver_id) || current_user.friend_requested?(@receiver_id)

    flash[:alert] = 'This user is already your friend or the friend request have been done before'
    redirect_back fallback_location: users_path
  end
end
