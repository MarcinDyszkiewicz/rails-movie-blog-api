json.data do
  json.id @like.try(:id)
  json.comment_id @comment.id
  json.like_type @like.try(:like_type)
end

json.message "Comment Liked"
json.success true