class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :liker
      t.references :likeable, polymorphic: true

      t.timestamps
    end
    add_foreign_key :likes, :users, column: :liker_id
  end
end
