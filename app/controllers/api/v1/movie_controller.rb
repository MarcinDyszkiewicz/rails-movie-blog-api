class Api::V1::MovieController < ApplicationController

def index
  movies = Movie.all

  render json: {data: movies, message: "Loaded all movies", success: true}, status: :ok
end

def create
  movie = Movie.create(movie_params)
  if movie.save
    render json: {data: movie, message: "Loaded all movies", success: true}, status: :ok
  else
    render json: {data: nil, message: movie.errors, success: false}, status: :unprocessable_entity
    end
end


private
  # movie strong params
  # @return [Object]
  def movie_params
    params.require(:movie).permit(:slug, :title, :year, :released, :runtime, :plot, :review, :poster, :rotten_tomatoes_rating, :metacritic_rating, :imdb_raiting)
  end

end
