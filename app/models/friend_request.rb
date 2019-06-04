# frozen_string_literal: true

class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  scope :related, ->(user_id, friend_id) { where('sender_id = ? AND receiver_id = ?', user_id, friend_id)
                                            .or(FriendRequest.where('sender_id = ? AND receiver_id = ?', friend_id, user_id)) }

  private
  def order_params
    self.sender_id, self.receiver_id = receiver_id, sender_id if receiver_id < sender_id
  end
end
