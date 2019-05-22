class Like < ApplicationRecord
  belongs_to :liker
  belongs_to :likeable, polymorphic: true
end
