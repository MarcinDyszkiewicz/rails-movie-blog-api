class Api::V1::PostController < ApplicationController


  private
  # movie strong params
  # @return [Object]
  def post_params
    params.require(:post).permit(:user_id, :movie_id, :slug, :title, :body, :image, :meta_title, :meta_description, :summary, :short_description, :catchy_title, :is_published, :published_at)
  end

end
