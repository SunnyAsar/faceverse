# frozen_string_literal: true

class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests, index: false do |t|
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps
    end
    add_index :friend_requests, %i[sender_id receiver_id]
    add_foreign_key :friend_requests, :users, column: :sender_id
    add_foreign_key :friend_requests, :users, column: :receiver_id
  end
end
