# frozen_string_literal: true

class FriendRequest < ApplicationRecord
  before_validation :validate_friendship

  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  scope :related, ->(user_id, friend_id) { where('sender_id = ? AND receiver_id = ?', user_id, friend_id)
                                            .or(FriendRequest.where('sender_id = ? AND receiver_id = ?', friend_id, user_id)) }

  private

  def validate_friendship
    sender = User.find(sender_id)
    receiver = User.find(receiver_id)
    errors.add(:receiver_id, "Already friends, you cannot send another request to this user") if sender.friend?(receiver) || receiver.request_from(sender) || sender.request_from(receiver)
  end
end
