class AddImdbIdToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :imdb_id, :text, uniquess: true
  end
end
