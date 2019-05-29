# frozen_string_literal: true

class FriendRequest < ApplicationRecord
  # before_create :order_params

  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'



  private
  def order_params
    self.sender_id, self.receiver_id = receiver_id, sender_id if receiver_id < sender_id
  end
end
