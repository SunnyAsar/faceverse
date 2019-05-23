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
  has_many :direct_friends, through: :friendships, source: :friend
  has_many :inverse_friends, through: :friendships, source: :user

  has_many :likes, foreign_key: :liker_id

  has_many :liked_posts, through: :likes, source: :likeable, source_type: "Post"
  has_many :liked_comments, through: :likes, source: :likeable, source_type: "Comment"









  def friends
    direct_friends + inverse_friends
  end





  # def self.my_friends(user)
  #   @friends = Friendship.where('user_id=?  OR friend_id=?', user.id, user.id)
  #   ids = []
  #   @friends.each do |friend|
  #     if friend.user_id == user.id do
  #       ids << friend.friend_id
  #     elsif friend.friend_id == user.id
  #       ids << friend.user_id
  #     end
  #   end



  #   puts 'welcome to friends'
  #   puts user.id
  #   @friends

  #   ids
  # end



end
