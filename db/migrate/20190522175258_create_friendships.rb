class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships, index: false do |t|
      t.references :user
      t.references :friend

      t.timestamps
    end
    add_index :friendships, %i[user_id friend_id]
    add_foreign_key :friendships, :users, column: :user_id
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
