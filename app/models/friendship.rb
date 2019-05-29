class Friendship < ApplicationRecord
  before_create :order_params

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

  # def existing_friendship?()

  # end

end