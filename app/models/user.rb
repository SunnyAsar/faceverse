# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :author_id

  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: :sender_id
  has_many :friends_requested, through: :sent_requests, source: :receiver

  has_many :received_requests, class_name: 'FriendRequest', foreign_key: :receiver_id
  has_many :friends_requesting, through: :received_requests, source: :sender

  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
end
