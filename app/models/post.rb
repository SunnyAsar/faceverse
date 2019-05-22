# frozen_string_literal: true

class Post < ApplicationRecord
  default_scope -> { order(created_at: :DESC) }
  scope :friends_posts -> { where() }

  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :commenters, through: :comments

  has_many :likes, as: :likeable
  has_many :likers, through: :likes
end
