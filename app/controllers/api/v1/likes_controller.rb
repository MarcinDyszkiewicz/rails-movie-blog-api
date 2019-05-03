class Api::V1::LikesController < ApplicationController
  before_action :set_like, only: [:show, :update, :destroy]

  # GET /likes
  # GET /likes.json
  def index
    comment = Comment.find(params[:comment_id])

    render json: {data: comment.likes, message: "All comment likes", success: true}, status: :ok
  end

  # GET /likes/1
  # GET /likes/1.json
  def show
  end

  # POST /likes
  # POST /likes.json
  def create
    @comment = Comment.find(params[:comment_id])
    user = current_user
    @like = Like.create_like_movie(like_params, @comment, user)
    if @like
      if @like.save
        render :show, status: :ok
        # render json: {data: comment.likes, message: "Comment Liked", success: true}, status: :created
      else
        render json: {data: nil, message: @like.errors, success: false}, status: :unprocessable_entity
      end
    else
      render :show, status: :ok

      # render json: {data: comment.likes, message: "Ok", success: true}, status: :ok
    end
  end

  # PATCH/PUT /likes/1
  # PATCH/PUT /likes/1.json
  def update
    if @like.update(like_params)
      render :show, status: :ok, location: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @like.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def like_params
      params.require(:like).permit(:like_type)
    end
end
