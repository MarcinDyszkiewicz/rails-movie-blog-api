class FindCreateImdbMovie
  require 'rest-client'

  def initialize(imdb_id)
    @imdb_id = imdb_id
  end

  def call
    find_or_create
  end

  private

  def find_or_create
    movie = find_in_database
    if movie
      movie
    else
      omdb_movie = get_from_omdb
      if omdb_movie
        create_from_omdb(omdb_movie)
      end
    end
  end

  def find_in_database
    Movie.find_by_imdb_id(@imdb_id)
  end

  def get_from_omdb
    response = RestClient.get "http://www.omdbapi.com/?apikey=c9d3739b", {params: {type: "movie", i: @imdb_id}}
    hash = JSON.parse(response.body)
    unless hash.key?("Error")
      hash.transform_keys! {|key| key.to_s.underscore}
      hash.symbolize_keys!
    end
  end

  def create_from_omdb(omdb_movie)
    actors = omdb_movie[:actors].split(/, /)
    genre_names = omdb_movie[:genre].split(/, /)
    genre_ids = Genre.where(name: genre_names).pluck(:id)
    omdb_movie[:imdb_raiting] = omdb_movie[:ratings].first["Value"]
    omdb_movie[:rotten_tomatoes_rating] = omdb_movie[:ratings].second["Value"]
    omdb_movie[:metacritic_rating] = omdb_movie[:ratings].third["Value"]
    movie_params = omdb_movie.slice(*Movie::STRONG_PARAMS)
    movie_params[:runtime] = movie_params[:runtime].split.first
    movie_data = {
        title: omdb_movie[:title],
        year: omdb_movie[:year],
        released: omdb_movie[:released],
        runtime: omdb_movie[:runtime]
    }

    movie = Movie.new_with_relations(movie_params, actors, omdb_movie[:director], genre_ids)
    if movie.save
      movie
    else
      raise Exception movie.errors
    end
  end
end

# t.string "slug", null: false
# t.string "title", null: false
# t.integer "year"
# t.date "released"
# t.integer "runtime"
# t.text "plot"
# t.text "review"
# t.string "poster"
# t.string "rotten_tomatoes_rating"
# t.string "metacritic_rating"
# t.string "imdb_raiting"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.text "imdb_id"
#
# "title\"=>\"Aquaman\", \"year\"=>\"2018\", \"rated\"=>\"PG-13\", \"released\"=>\"21 Dec 2018\", \"runtime\"=>\"143 min\", \"genre\"=>\"Action, Adventure, Fantasy, Sci-Fi\", \"director\"=>\"James Wan\", \"writer\"=>\"David Leslie Johnson-McGoldrick (screenplay by), Will Beall (screenplay by), Geoff Johns (story by), James Wan (story by), Will Beall (story by), Mort Weisinger (Aquaman created by), Paul Norris (Aquaman created by)\", \"actors\"=>\"Jason Momoa, Amber Heard, Willem Dafoe, Patrick Wilson\", \"plot\"=>\"Arthur Curry, the human-born heir to the underwater kingdom of Atlantis, goes on a quest to prevent a war between the worlds of ocean and land.\", \"language\"=>\"English\", \"country\"=>\"Australia, USA\", \"awards\"=>\"N/A\", \"poster\"=>\"https://m.media-amazon.com/images/M/MV5BOTk5ODg0OTU5M15BMl5BanBnXkFtZTgwMDQ3MDY3NjM@._V1_SX300.jpg\", \"ratings\"=>[{\"Source\"=>\"Internet Movie Database\", \"Value\"=>\"7.2/10\"}, {\"Source\"=>\"Rotten Tomatoes\", \"Value\"=>\"65%\"}, {\"Source\"=>\"Metacritic\", \"Value\"=>\"55/100\"}], \"metascore\"=>\"55\", \"imdb_rating\"=>\"7.2\", \"imdb_votes\"=>\"208,461\", \"imdb_id\"=>\"tt1477834\", \"type\"=>\"movie\", \"dvd\"=>\"N/A\", \"box_office\"=>\"N/A\", \"production\"=>\"Warner Bros. Pictures\", \"website\"=>\"http://www.aquamanmovie.com/\", \"response\"=>\"True\"}>",