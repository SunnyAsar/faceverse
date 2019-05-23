class Friendship < ApplicationRecord
  # after_create_commit :create_inverse_frienship
  # after_destroy_commit :destroy_inverse_frienship
  before_create :order_params

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

  def order_params
    self.user_id, self.friend_id = friend_id, user_id if friend_id < user_id
  end
end
