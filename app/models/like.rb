# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :liker, class_name: 'User'
  belongs_to :likeable, polymorphic: true

  scope :for, ->(id, type) { where('likeable_id = ? AND likeable_type = ?', id, type).first }
end
