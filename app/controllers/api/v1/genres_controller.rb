class Api::V1::GenresController < ApplicationController
  def index
    genres = Genre.includes(:movies)
    render json: {data: genres, message: "Loaded all genres", success: true}, status: :ok
  end

  def create
    genre = Genre.new(genre_params)
    if genre.save
      render json: {data: genre, message: "Genre created", success: true}, status: :created
    else
      render json: {data: nil, message: genre.errors, success: false}, status: :unprocessable_entity
    end
  end

  def update
    genre = Genre.find(params[:id])
    if genre.update!(genre_params)
      render json: {data: genre, message: "Genre updated", success: true}, status: :created
    else
      render json: {data: nil, message: genre.errors, success: false}, status: :unprocessable_entity
    end
  end

  def show
    genre = Genre.find(params[:id])
    render json: {data: genre, message: "Loaded genre", success: true}, status: :ok
  end

  def destroy
    genre = Genre.find(params[:id])
    if genre.delete
      render json: {data: nil, message: "Genre deleted", success: true}, status: :ok
    else
      render json: {data: nil, message: genre.errors, success: false}, status: :unprocessable_entity
    end
  end

  private
  # genre strong params
  # @return [Object]
  def genre_params
    params.require(:genre).permit(:slug, :name)
  end
end
