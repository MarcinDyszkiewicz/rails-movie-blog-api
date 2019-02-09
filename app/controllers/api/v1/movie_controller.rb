class Api::V1::MovieController < ApplicationController




private

  # movie strong params
  # @return [Object]
  def movie_params
    params.require(:movie).permit(:slug, :title, :year, :released, :runtime, :plot, :review, :poster, :rotten_tomatoes_rating, :metacritic_rating, :imdb_raiting)
  end
end
