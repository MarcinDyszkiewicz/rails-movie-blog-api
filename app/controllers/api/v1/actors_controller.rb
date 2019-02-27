class Api::V1::ActorsController < ApplicationController
  def index
    actors = Actor.includes(:movies)
    render json: {data: actors, message: "Loaded all actors", success: true}, status: :ok
  end

  def create
    actor = Actor.new(actor_params)
    if actor.save
      render json: {data: actor, message: "Actor created", success: true}, status: :created
    else
      render json: {data: nil, message: actor.errors, success: false}, status: :unprocessable_entity
    end
  end

  def update
    actor = Actor.find(params[:id])
    if actor.update!(actor_params)
      render json: {data: actor, message: "Actor updated", success: true}, status: :created
    else
      render json: {data: nil, message: actor.errors, success: false}, status: :unprocessable_entity
    end
  end

  def show
    @actor = Actor.find(params[:id])
    render :show, status: :ok
  end

  def destroy
    actor = Actor.find(params[:id])
    if actor.delete
      render json: {data: nil, message: "Actor deleted", success: true}, status: :ok
    else
      render json: {data: nil, message: actor.errors, success: false}, status: :unprocessable_entity
    end
  end

  private
  # actor strong params
  # @return [Object]
  def actor_params
    params.require(:actor).permit(:slug, :full_name, :poster)
  end

end
