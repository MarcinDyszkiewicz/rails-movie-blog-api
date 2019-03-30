class Api::V1::PostsController < ApplicationController

def index
  posts = Post.all
  render json: {data: posts, message: "Loaded all posts", success: true}, status: :ok
end

def create
  @post = Post.new_with_relations(post_params, params[:category_ids], params[:tags], params[:imdb_id], params[:movie_id])
  if @post
    render json: {data: @post, message: "Post created", success: true}, status: :created
  else
    render json: {data: nil, message: @post.errors, success: false}, status: :unprocessable_entity
  end
end

def update
  post = Post.find(params[:id])
  if post.update!(post_params)
    render json: {data: post, message: "Post updated", success: true}, status: :created
  else
    render json: {data: nil, message: post.errors, success: false}, status: :unprocessable_entity
  end
end

def show
  post = Post.find(params[:id])
  render json: {data: [post, post.comments], message: "Loaded post", success: true}, status: :ok
end

def destroy
  post = Post.find(params[:id])
  if post.delete
    render json: {data: nil, message: "Post deleted", success: true}, status: :ok
  else
    render json: {data: nil, message: post.errors, success: false}, status: :unprocessable_entity
  end
end

def search
  @posts = Post.select("id, title, short_description")
               .where("title LIKE ?", "#{params[:title]}%")
               .where(is_published: true)
  render json: {data: @posts, message: "Loaded posts", success: true}, status: :ok
end

def popular
  @posts = Post.joins(:categories).where(categories: {name: "popular"}).select("posts.id, title, short_description").limit(5)
  render json: {data: @posts, message: "Loaded popular posts", success: true}, status: :ok
end

def hot
  @posts = Post.joins(:categories).where(categories: {name: "popular"}).select("posts.id, title, short_description").limit(5)
  render json: {data: @posts, message: "Loaded hot posts", success: true}, status: :ok
end

  private
  # post strong params
  # @return [Object]
  def post_params
    params.require(:post).permit(:user_id, :post_id, :slug, :title, :body, :image, :meta_title, :meta_description, :summary, :short_description, :catchy_title, :is_published, :published_at)
  end

end
