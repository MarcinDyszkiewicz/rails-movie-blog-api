class OmdbMovieFinder
  require 'rest-client'

  # def initialize(imdb_id)
  #   @imdb_id = imdb_id
  # end

  def find_movies_by_title(title)
    response = RestClient.get "http://www.omdbapi.com/?apikey=c9d3739b", {params: {type: "movie", s: title}}
    hash = JSON.parse(response.body)
    unless hash.key?("Error")
      if hash.key?("Search")
        movies_array = hash["Search"]
        movies_array.each do |movie|
          movie.transform_keys! {|key| key.to_s.underscore}
          movie.symbolize_keys!
        end
        # abort movies_array.inspect
        # hash.symbolize_keys!
      end

    end
  end

  def find_movies_by_year

  end

  # private
  #
  # def find_or_create
  #   movie = find_in_database
  #   if movie
  #     movie
  #   else
  #     omdb_movie = get_from_omdb
  #     if omdb_movie
  #       create_from_omdb(omdb_movie)
  #     end
  #   end
  # end
  #
  # def find_in_database
  #   Movie.find_by_imdb_id(@imdb_id)
  # end
  #
  # def get_from_omdb
  #   response = RestClient.get "http://www.omdbapi.com/?apikey=c9d3739b", {params: {type: "movie", i: @imdb_id}}
  #   hash = JSON.parse(response.body)
  #   unless hash.key?("Error")
  #     hash.transform_keys! {|key| key.to_s.underscore}
  #     hash.symbolize_keys!
  #   end
  # end
  #
  # # @param [Object] omdb_movie
  # def create_from_omdb(omdb_movie)
  #   actors = omdb_movie[:actors].split(/, /)
  #   genre_names = omdb_movie[:genre].split(/, /)
  #   genre_ids = Genre.where(name: genre_names).pluck(:id)
  #   omdb_movie[:imdb_raiting] = omdb_movie[:ratings].first["Value"]
  #   omdb_movie[:rotten_tomatoes_rating] = omdb_movie[:ratings].second["Value"]
  #   omdb_movie[:metacritic_rating] = omdb_movie[:ratings].third["Value"]
  #   movie_params = omdb_movie.slice(*Movie::STRONG_PARAMS)
  #   movie_params[:runtime] = movie_params[:runtime].split.first
  #
  #   movie = Movie.new_with_relations(movie_params, actors, omdb_movie[:director], genre_ids)
  #   if movie.save
  #     movie
  #   else
  #     raise Exception movie.errors
  #   end
  # end
end
