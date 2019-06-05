# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :posts, foreign_key: :author_id, dependent: :destroy

  has_many :comments, foreign_key: :commenter_id, dependent: :destroy

  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: :sender_id, dependent: :destroy
  has_many :friends_requested, through: :sent_requests, source: :receiver

  has_many :received_requests, class_name: 'FriendRequest', foreign_key: :receiver_id, dependent: :destroy
  has_many :friends_requesting, through: :received_requests, source: :sender

  has_many :direct_friendships, class_name: 'Friendship', foreign_key: :user_id, dependent: :destroy
  has_many :direct_friends, through: :direct_friendships, source: :friend

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id, dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :likes, foreign_key: :liker_id, dependent: :destroy

  has_many :liked_posts, through: :likes, source: :likeable, source_type: 'Post'
  has_many :liked_comments, through: :likes, source: :likeable, source_type: 'Comment'

  def friends
    direct_friends + inverse_friends
  end

  def send_friend_request(user_id)
    sent_requests.create(receiver_id: user_id)
  end

  def friend_requests
    friends_requesting
  end
end
