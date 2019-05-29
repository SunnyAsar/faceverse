# require 'byebug'

class FriendRequestsController < ApplicationController
  before_action :set_receiver_id, only: :create
  before_action :validate_creation, only: :create
  before_action :validate_inverse_request, only: :create

  def index
    @requests = current_user.friend_requests
  end

  def create
    @friend_request = current_user.send_friend_request(@receiver_id)
    redirect_to users_path
  end

  def destroy; end

  private

  def friend_request_params
    params.require(:friend_request).permit(:receiver_id)
  end

  def set_receiver_id
    @receiver_id = friend_request_params[:receiver_id].to_i
  end

  def validate_creation
    return unless current_user.friend?(@receiver_id) || current_user.friend_requested?(@receiver_id)

    flash[:alert] = 'This user is already your friend or the friend request have been done before'
    redirect_to users_path
  end

  def validate_inverse_request
    # debugger
    return unless current_user.friend_requesting?(@receiver_id)

    current_user.add_friend(@receiver_id)
    current_user.delete_friend_request(@receiver_id)
    redirect_to users_path
  end
end
