class Api::V1::CommentsController < ApplicationController
  # before_action find_commentable on: :index

  def index
    @commentable_model = find_commentable
    @comments = @commentable_model.comments.where(comment_parent_id: nil)
    @user = current_user
    render :index, status: :ok
  end

  def create
    commentable_model = find_commentable
    @comment = commentable_model.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      render json: {data: @comment, message: "Comment created", success: true}, status: :created
    else
      render json: {data: nil, message: @comment.errors, success: false}, status: :unprocessable_entity
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

  def child_comments
    @comments = Comment.where(comment_parent_id: params[:id])
    @user = current_user
    render :index, status: :ok
  end

  private
  # comment strong params
  # @return [Object]
  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :movie_id, :comment_parent_id, :body)
  end

  # @return [Model]
  def find_commentable
    if params[:movie_id]
      @commentable_model = Movie.find(params[:movie_id])
    elsif params[:post_id]
      @commentable_model = Post.find(params[:post_id])
    else
      raise Exception.new("Not found")
    end
  end
end
