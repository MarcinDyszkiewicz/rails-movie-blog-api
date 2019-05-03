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
  end
end

json.message "Loaded Comments"
json.success true