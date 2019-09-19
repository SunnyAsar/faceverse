class Friendship < ApplicationRecord
  before_create :order_params
  after_create :delete_this_request

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :not_self_friendship

  private

  def order_params
    self.user_id, self.friend_id = friend_id, user_id if friend_id < user_id
  end

  def not_self_friendship
    errors.add(:user_id, "can't create relationship with itself") if user_id == friend_id
  end

  def delete_this_request
    FriendRequest.related(user_id, friend_id).first&.destroy
  end
end
