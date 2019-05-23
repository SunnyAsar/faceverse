class Friendship < ApplicationRecord
  after_create_commit :create_inverse_frienship
  after_destroy_commit :destroy_inverse_frienship

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

  def create_inverse_frienship
    puts 'running after create callback'
    Friendship.create(user_id: friend_id, friend_id: user_id) unless Friendship.where(user_id: friend_id, friend_id: user_id).any?
  end

  def destroy_inverse_frienship
    puts 'running after destroy callback'
    Friendship.where(user_id: friend_id, friend_id: user_id).first&.destroy
  end

end
