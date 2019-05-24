class Comment < ApplicationRecord

  belongs_to :post
  belongs_to :commenter, class_name: "User"
  has_many :likes, as: :likeable, dependent: :destroy


  validates :content, presence: true
  validates :commenter, presence: true

  
end
