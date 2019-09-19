class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :country
      t.integer :age
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
