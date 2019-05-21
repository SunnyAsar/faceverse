class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :author_id
  has_many :friends_requested, class_name: "FriendRequest", foreign_key: :sender_id
  has_many :friends_requesting, class_name: "FriendRequest", foreign_key: :receiver_id


  has_many :sent_requests, through: :friends_requested, source: :receiver

  has_many :received_requests, through: :friends_requesting, source: :sender
  

end
