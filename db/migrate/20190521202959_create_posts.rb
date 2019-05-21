class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :author_id

      t.timestamps
    end
    add_foreign_key :posts, :users, column: :author_id
  end
end
