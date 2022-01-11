module ApplicationHelper
  def post_owner?(post:)
    post.user_id == current_user&.id
  end
end
