class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.integer :sender_id, index: true
      t.integer :receiver_id, index: true

      t.timestamps
    end
    add_foreign_key :friend_requests, :users, column: :sender_id
    add_foreign_key :friend_requests, :users, column: :receiver_id
  end
end
