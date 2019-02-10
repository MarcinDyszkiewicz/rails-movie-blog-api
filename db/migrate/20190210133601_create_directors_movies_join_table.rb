class CreateDirectorsMoviesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :directors, :movies do |t|
      t.index [:director_id, :movie_id]
      t.index [:movie_id, :director_id]
    end
  end
end
