class Like < ApplicationRecord
  TYPE_LIKE = 10
  TYPE_DISLIKE = 20

  belongs_to :user
  belongs_to :comment

  validates_presence_of :like_type, :user, :comment
  validates :comment, uniqueness: { scope: :user, message: "This user already liked this post", case_sensitive: false }
  validates :like_type, inclusion: { in: [self::TYPE_LIKE, self::TYPE_DISLIKE] }



  def self.create_like_movie(like_params, comment, user)
    type = like_params[:like_type]
    like = Like.where(comment_id: comment.id, user_id: user.id).first
    if like
      like_type = like.like_type
      like.destroy
      if like_type != type
        like = comment.likes.create(like_type: type, user: user)
      end
    else
      like = comment.likes.create(like_type: type, user: user)
    end
  end
end
