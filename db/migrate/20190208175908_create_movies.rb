class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :slug, null: false, unique: true
      t.string :title, null: false
      t.integer :year
      t.date :released
      t.integer :runtime
      t.text :plot
      t.text :review
      t.string :poster
      t.string :rotten_tomatoes_rating
      t.string :metacritic_rating
      t.string :imdb_raiting

      t.timestamps
    end
    add_index :movies, [:title, :year], unique: true
  end
end
