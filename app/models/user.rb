# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :commenter_id

  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: :sender_id
  has_many :friends_requested, through: :sent_requests, source: :receiver

  has_many :received_requests, class_name: 'FriendRequest', foreign_key: :receiver_id
  has_many :friends_requesting, through: :received_requests, source: :sender

  has_many :friendships,  dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

  has_many :likes, foreign_key: :liker_id

  has_many :liked_posts, through: :likes, source: :likeable, source_type: "Post"
  has_many :liked_comments, through: :likes, source: :likeable, source_type: "Comment"






  def self.my_friends
    # @friends = Friendship.where('user_id=?  OR friend_id=?', current_user.id)
    # @friends = Friendship.where(user_id: user.id)
    puts 'welcome to friends'
  end
end
