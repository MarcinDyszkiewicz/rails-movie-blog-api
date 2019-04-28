class Api::V1::MoviesController < ApplicationController

def index
  @movies = Movie.includes(:actors, :directors, :genres).limit(20)
  render :index, status: :ok
end

def create
  @movie = Movie.new_with_relations(movie_params, params[:actors], params[:director], params[:genre_ids])
  if @movie
    @message = "Movie Created"
    render :show, status: :created
  else
    render json: {data: nil, message: @movie.errors, success: false}, status: :unprocessable_entity
  end
end

def update
  @movie = Movie.find(params[:id])
  if @movie.update_with_relations(movie_params, params[:actors], params[:director], params[:genre_ids])
    @message = "Movie Updated"
    render :show, status: :created
  else
    render json: {data: nil, message: @movie.errors, success: false}, status: :unprocessable_entity
  end
end

def show
  @movie = Movie.find(params[:id])
  render :show, status: :ok
end

def destroy
  movie = Movie.find(params[:id])
  if movie.delete
    render json: {data: nil, message: "Movie deleted", success: true}, status: :ok
  else
    render json: {data: nil, message: movie.errors, success: false}, status: :unprocessable_entity
  end
end

def rate
  movie = Movie.find(params[:id])
    user = current_user
    rating = movie.ratings.new(rate: params[:rate], user_id: user.id)
    if rating.save
    render json: {data: rating, message: "Movie rated", success: true}, status: :ok
  else
    render json: {data: nil, message: rating.errors, success: false}, status: :unprocessable_entity
    end
end

private
  # movie strong params
  # @return [Object]
  def movie_params
    params.require(:movie).permit(*STRONG_PARAMS)
  end
end
