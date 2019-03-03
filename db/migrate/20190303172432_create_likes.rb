class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :likeable, polymorphic: true
      t.integer :type

      t.timestamps
    end
  end
end
