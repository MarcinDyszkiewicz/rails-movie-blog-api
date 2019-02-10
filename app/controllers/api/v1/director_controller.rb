class Api::V1::DirectorController < ApplicationController
  def index
    directors = Director.all
    render json: {data: directors, message: "Loaded all directors", success: true}, status: :ok
  end

  def create
    director = Director.new(director_params)
    if director.save
      render json: {data: director, message: "Director created", success: true}, status: :created
    else
      render json: {data: nil, message: director.errors, success: false}, status: :unprocessable_entity
    end
  end

  def update
    director = Director.find(params[:id])
    if director.update!(director_params)
      render json: {data: director, message: "Director updated", success: true}, status: :created
    else
      render json: {data: nil, message: director.errors, success: false}, status: :unprocessable_entity
    end
  end

  def show
    director = Director.find(params[:id])
    render json: {data: director, message: "Loaded director", success: true}, status: :ok
  end

  def destroy
    director = Director.find(params[:id])
    if director.delete
      render json: {data: nil, message: "Director deleted", success: true}, status: :ok
    else
      render json: {data: nil, message: director.errors, success: false}, status: :unprocessable_entity
    end
  end

  private
  # director strong params
  # @return [Object]
  def director_params
    params.require(:director).permit(:slug, :full_name, :poster)
  end
end
