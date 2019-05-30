# frozen_string_literal: true

class Comment < ApplicationRecord
  self.per_page = 2
  # scope :pagination, ->{ paginate(page: params[:page], per_page: 3 }

  belongs_to :post
  belongs_to :commenter, class_name: 'User'
  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true
end
