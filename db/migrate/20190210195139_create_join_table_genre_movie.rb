class CreateJoinTableGenreMovie < ActiveRecord::Migration[5.2]
  def change
    create_join_table :genres, :movies do |t|
      t.index [:genre_id, :movie_id]
      t.index [:movie_id, :genre_id]
    end
  end
end
