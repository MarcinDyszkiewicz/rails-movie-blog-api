class Api::V1::CommentController < ApplicationController
  def index
    comments = Comment.all
    render json: {data: comments, message: "Loaded all comments", success: true}, status: :ok
  end

  def create
    comment = Comment.new_for_post_or_movie(comment_params, params[:post_id], params[:movie_id])
    if comment.save
      render json: {data: comment, message: "Comment created", success: true}, status: :created
    else
      render json: {data: nil, message: comment.errors, success: false}, status: :unprocessable_entity
    end
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update!(comment_params[:body])
      render json: {data: comment, message: "Comment updated", success: true}, status: :created
    else
      render json: {data: nil, message: comment.errors, success: false}, status: :unprocessable_entity
    end
  end

  def show
    comment = Comment.find(params[:id])
    render json: {data: comment, message: "Loaded comment", success: true}, status: :ok
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.delete
      render json: {data: nil, message: "Comment deleted", success: true}, status: :ok
    else
      render json: {data: nil, message: comment.errors, success: false}, status: :unprocessable_entity
    end
  end

  def index_for_post
    movies = Movie.all
    render json: {data: movies, message: "Loaded all movies", success: true}, status: :ok
  end

  def index_for_movie

  end

  private
  # comment strong params
  # @return [Object]
  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :movie_id, :comment_parent_id, :body)
  end
end
