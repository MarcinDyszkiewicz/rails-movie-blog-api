class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: true
      t.integer :rate, limit: 2
      t.references :ratingable, polymorphic: true

      t.timestamps
    end
    add_index :ratings, [:user_id, :ratingable_id, :ratingable_type], unique: true
  end
end
