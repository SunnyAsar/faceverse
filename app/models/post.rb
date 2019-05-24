# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content, presence: true
  validates :author, presence: true

  default_scope -> { order(created_at: :desc) }

  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  # has_many :commenters, through: :comments,dependent: :destroy


  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes
end
