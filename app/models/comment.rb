class Comment < ApplicationRecord
  #relations
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes

  #validations
  validates :body, presence: true, length: { minimum: 5, maximum: 2000}, uniqueness: { scope: [:user, :commentable_type, :commentable_id], message: "You Can't duplicate comments", case_sensitive: false }

  def self.new_for_post_or_movie(comment_params, post_id = nil, movie_id = nil )
    body = comment_params[:body]

    if post_id
      post = Post.find(post_id)
      unless post
        raise Exception.new("Post not found")
      end
      # logger.debug "comments: #{post.comments.}"
      # logger.debug "comments: #{post.comments.where(comments: { body: params[:body] })}"

      if post.comments.exists?(body: body)
        raise Exception.new("You Can't duplicate comments")
      end

      return post.comments.new(comment_params)

    elsif movie_id
      movie = Movie.find(movie_id)
      unless movie
        raise Exception.new("Movie not found")
      end
      if movie.comments.exists?(body: body)
        raise Exception.new("You Can't duplicate comments")
      end

      return movie.comments.new(comment_params)
    end
  end

  def self.new_for_movie(comment_params, movie_id)
    movie = Movie.find(movie_id)

    if movie

    end
  end

  def child_comments
    Comment.where(comment_parent_id: self.id)
  end

  def count_likes
    likes = self.likes.where(like_type: Like::TYPE_LIKE).count
    dislikes = self.likes.where(like_type: Like::TYPE_DISLIKE).count
    likes - dislikes
  end

  def user_like_type(user_id)
    self.likes.where(user_id: user_id).first.try(:like_type)
  end
end
