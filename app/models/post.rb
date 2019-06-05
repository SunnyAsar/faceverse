# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content, presence: true

  default_scope -> { order(created_at: :desc) }

  scope :feed_for, ->(user) { where(author_id: (user.friends.pluck(:id) << user.id)) }

  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes
end
