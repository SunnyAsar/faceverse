# frozen_string_literal: true
require 'byebug'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :first_name, presence: true
  after_create :create_profile
  scope :all_without, ->(user){ where.not(id: user.id)}




  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

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

  def friend?(user_id)
    friends.map(&:id).include?(user_id)
  end

  def friend_requested?(user_id)
    friends_requested.pluck(:id).include?(user_id)
  end

  def friend_requesting?(user_id)
    friends_requesting.pluck(:id).include?(user_id)
  end

  def request_from(user_id)
    received_requests.where(sender_id: user_id).first
  end

  def friend_requests
    friends_requesting
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def likes_post?(post_id)
    liked_posts.pluck(:id).include?(post_id)
  end

  def likes_comment?(comment_id)
    liked_comments.pluck(:id).include?(comment_id)
  end

  def post_like(post_id)
    likes.for(post_id, 'Post')
  end

  def comment_like(comment_id)
    likes.for(comment_id, 'Comment')
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name
    end
  end

  private

  def create_profile
    Profile.create(user: self)
    puts 'creating profile .....'
  end
end
