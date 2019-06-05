class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :post, foreign_key: true
      t.integer :commenter_id

      t.timestamps
    end
    add_foreign_key :comments, :users, column: :commenter_id
  end
end
