class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :commenter, class_name: "User"
  
end
