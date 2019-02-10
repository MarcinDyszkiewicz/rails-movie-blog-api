class Api::V1::MovieController < ApplicationController

def index
  movies = Movie.includes(:actors).limit(20)
  render json: {data: movies, message: "Loaded all movies", success: true}, status: :ok
end

def create
  movie = Movie.new_with_relations(movie_params, params[:actors])
  if movie
    render json: {data: movie, message: "Movie created", success: true}, status: :created
  else
    render json: {data: nil, message: movie.errors, success: false}, status: :unprocessable_entity
  end
end

def update
  movie = Movie.find(params[:id])
  if movie.update!(movie_params)
    render json: {data: movie, message: "Movie updated", success: true}, status: :created
  else
    render json: {data: nil, message: movie.errors, success: false}, status: :unprocessable_entity
  end
end

def show
  movie = Movie.find(params[:id])
  render json: {data: movie, message: "Loaded movie", success: true}, status: :ok
end

def destroy
  movie = Movie.find(params[:id])
  if movie.delete
    render json: {data: nil, message: "Movie deleted", success: true}, status: :ok
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
