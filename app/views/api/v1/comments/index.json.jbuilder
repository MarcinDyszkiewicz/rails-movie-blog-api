json.data do
  json.array! @comments do |comment|
    json.id comment.id
    json.comment_parent_id comment.comment_parent_id
    json.body comment.body
    json.is_spoiler comment.is_spoiler
    json.created_at comment.created_at.to_date
    json.user_name comment.user.try(:email)
    json.likes comment.count_likes
    json.user_like_type @user ? comment.user_like_type(@user.id) : nil

    json.child_comments comment.child_comments do |child_comment|
      json.id child_comment.id
      json.comment_parent_id child_comment.comment_parent_id
      json.body child_comment.body
      json.is_spoiler child_comment.is_spoiler
      json.created_at child_comment.created_at.to_date
      json.user_name child_comment.user.try(:email)
      json.likes child_comment.count_likes
      json.user_like_type @user ? child_comment.user_like_type(@user.id) : nil
    end

  end
end

json.message "Comments Loaded"
json.success true